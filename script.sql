/** SCRIPT CREATION TABLE **/

DROP TABLE PARTICIPATES;
DROP TABLE EVENTS;
DROP TABLE USERS;

CREATE TABLE USERS (
  idUser varchar2(255),
  numberIdentification varchar2(255),
  lastname varchar2(255),
  firstname varchar2(255),
  address varchar2(255),
  phone varchar2(255),
  CONSTRAINT ADMIN18_PK_USERS PRIMARY KEY (idUser)
); 

CREATE TABLE EVENTS (
  idEvent varchar2(255),
  idUser varchar2(255),
  dateEvent varchar2(255),
  placeEvent varchar2(255),
  nameEvent varchar2(255),
  typeEvent varchar2(255),
  cost number(10),
  nbReservedScenes number(10),
  nbReservedBooth number(10),
  comments varchar2(255),
  CONSTRAINT ADMIN18_PK_EVENTS PRIMARY KEY (idEvent),
  CONSTRAINT ADMIN18_FK_EVENTS_USERS FOREIGN KEY (idUser)
  REFERENCES USERS (idUser)
);

CREATE TABLE PARTICIPATES (
  idEvent varchar2(255),
  idUser varchar2(255),
  dateRegistre varchar2(255),
  CONSTRAINT ADMIN18_PK_PARTICIPATES PRIMARY KEY (idEvent,idUser),
  CONSTRAINT ADMIN18_FK_PARTICIPATES_EVENTS FOREIGN KEY (idEvent)
  REFERENCES EVENTS(idEvent),
  CONSTRAINT ADMIN18_FK_PARTICIPATES_USERS FOREIGN KEY (idUser)
  REFERENCES USERS (idUser)
); 

DROP VIEW VUE_EVENTS;
CREATE VIEW VUE_EVENTS 
	AS SELECT idEvent,idUser,dateEvent,placeEvent,nameEvent,typeEvent 
	FROM EVENTS ;

/**  FIN SCRIPT CREATION TABLE  **/

/** SCRIPT CREATION ROLE **/
DROP ROLE ADMIN18_ROLE_ADMIN;
DROP ROLE ADMIN18_ROLE_COLLECTIVITY;
DROP ROLE ADMIN18_ROLE_ORGANIZER;
DROP ROLE ADMIN18_ROLE_PARTICIPATE;
CREATE ROLE ADMIN18_ROLE_ADMIN;
CREATE ROLE ADMIN18_ROLE_COLLECTIVITY;
CREATE ROLE ADMIN18_ROLE_ORGANIZER;
CREATE ROLE ADMIN18_ROLE_PARTICIPATE;
/** FIN SCRIPT CREATION ROLE **/


/** SCRIPT CREATION PRIVILEGE POUR LES ROLES **/
GRANT SELECT ON VUE_EVENTS TO ADMIN18_ROLE_COLLECTIVITY;
GRANT SELECT ON PARTICIPATES TO ADMIN18_ROLE_COLLECTIVITY;

GRANT ADMIN18_ROLE_COLLECTIVITY TO ADMIN18_ROLE_PARTICIPATE;
GRANT SELECT,UPDATE(lastname,firstname,address,phone) ON USERS TO ADMIN18_ROLE_PARTICIPATE;
GRANT INSERT,DELETE ON PARTICIPATES TO ADMIN18_ROLE_PARTICIPATE;

GRANT ADMIN18_ROLE_COLLECTIVITY TO ADMIN18_ROLE_ORGANIZER;
GRANT SELECT,UPDATE(lastname,firstname,address,phone) ON USERS TO ADMIN18_ROLE_ORGANIZER;
GRANT SELECT,UPDATE,INSERT,DELETE ON EVENTS TO ADMIN18_ROLE_ORGANIZER;
GRANT SELECT ON PARTICIPATES TO ADMIN18_ROLE_ORGANIZER;

GRANT SELECT,INSERT,UPDATE,DELETE ON USERS TO ADMIN18_ROLE_ADMIN;
GRANT SELECT,INSERT,UPDATE,DELETE ON EVENTS TO ADMIN18_ROLE_ADMIN;
GRANT SELECT,INSERT,UPDATE,DELETE ON VUE_EVENTS TO ADMIN18_ROLE_ADMIN;
/** FIN SCRIPT CREATION PRIVILEGE POUR LES ROLES **/

/**  SCRIPT JEU ESSAI **/
GRANT ADMIN18_ROLE_ADMIN TO USER1;
GRANT ADMIN18_ROLE_ORGANIZER TO USER2;
GRANT ADMIN18_ROLE_ORGANIZER TO USER3;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER4;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER5;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER6;
GRANT ADMIN18_ROLE_COLLECTIVITY TO USER7;

COMMIT;


/** SCRIPT CREATION CONTEXT APPLICATION **/
CREATE OR REPLACE CONTEXT USER_CTX USING set_user_ctx_pkg;
/

CREATE OR REPLACE PACKAGE set_user_ctx_pkg IS 
  PROCEDURE set_user;
END;
/

CREATE OR REPLACE PACKAGE BODY set_user_ctx_pkg IS
  PROCEDURE set_user IS
    myRole VARCHAR2(255);
  BEGIN 
    SELECT GRANTED_ROLE INTO myRole
    FROM DBA_ROLE_PRIVS
    WHERE GRANTEE = SYS_CONTEXT('USERENV','SESSION_USER')
    AND GRANTED_ROLE LIKE 'ADMIN18%';
    DBMS_SESSION.SET_CONTEXT('USER_CTX','role',myRole);
    DBMS_SESSION.SET_CONTEXT('USER_CTX','idUser',SYS_CONTEXT('USERENV','SESSION_USER'));
  END set_user;
END set_user_ctx_pkg;
/
/** **/
GRANT EXECUTE ON set_user_ctx_pkg TO USER1;
GRANT EXECUTE ON set_user_ctx_pkg TO USER2;
GRANT EXECUTE ON set_user_ctx_pkg TO USER3;
GRANT EXECUTE ON set_user_ctx_pkg TO USER4;
GRANT EXECUTE ON set_user_ctx_pkg TO USER5;
GRANT EXECUTE ON set_user_ctx_pkg TO USER6;
GRANT EXECUTE ON set_user_ctx_pkg TO USER7;
COMMIT;

/** POLICY*/
BEGIN
  DBMS_RLS.DROP_POLICY ('ADMIN18','USERS','users_policy');
END;
/

BEGIN
  DBMS_RLS.ADD_POLICY (
  object_schema => 'ADMIN18',
  object_name => 'USERS',
  policy_name => 'users_policy',
  function_schema => 'ADMIN18',
  policy_function => 'auth_users',
  statement_types => 'select,update'
);
END;
/


/** VPD SELECT USER **/
CREATE OR REPLACE FUNCTION auth_users(schema_var IN VARCHAR2,table_var IN VARCHAR2)
RETURN VARCHAR2
IS
  role VARCHAR2(400);
  return_val VARCHAR2 (400);
BEGIN
  role := SYS_CONTEXT('USER_CTX','role');
  IF role = 'ADMIN18_ROLE_PARTICIPATES' OR role = 'ADMIN18_ROLE_ORGANIZER' THEN
    return_val := 'idUser=SYS_CONTEXT(''USER_CTX'',''idUser'')';
  ELSE
    return_val := '1=1';
  END IF;
  RETURN return_val;
END;
/

BEGIN
  DBMS_RLS.DROP_POLICY ('ADMIN18','EVENTS','events_policy');
END;
/

/* VPD par colonne*/
BEGIN
  DBMS_RLS.ADD_POLICY (
  object_schema => 'ADMIN18',
  object_name => 'EVENTS',
  policy_name => 'events_policy',
  function_schema => 'ADMIN18',
  policy_function => 'auth_events',
  statement_types => 'select,insert,update,delete'
);
END;
/

/** VPD SELECT USER **/
CREATE OR REPLACE FUNCTION auth_events(schema_var IN VARCHAR2,table_var IN VARCHAR2)
RETURN VARCHAR2
IS
  role VARCHAR2(400);
  return_val VARCHAR2 (400);
BEGIN
  role := SYS_CONTEXT('USER_CTX','role');
  IF role = 'ADMIN18_ROLE_ORGANIZER' THEN
    return_val := 'idUser=SYS_CONTEXT(''USER_CTX'',''idUser'')';
  ELSE
    return_val := '1=1';
  END IF;
  RETURN return_val;
END;
/

BEGIN
  DBMS_RLS.DROP_POLICY ('ADMIN18','PARTICIPATES','participate_policy');
END;
/

/** Ajout de l'option update_check pour verifier les insert et update*/
/* VPD sur les participation*/
BEGIN
  DBMS_RLS.ADD_POLICY (
  object_schema => 'ADMIN18',
  object_name => 'PARTICIPATES',
  policy_name => 'participate_policy',
  function_schema => 'ADMIN18',
  policy_function => 'auth_participate',
  statement_types => 'select,insert,delete',
  update_check => TRUE
);
END;
/

/** VPD SELECT Participate (organizer)**/
CREATE OR REPLACE FUNCTION auth_participate(schema_var IN VARCHAR2,table_var IN VARCHAR2)
RETURN VARCHAR2
IS
  role VARCHAR2(400);
  return_val VARCHAR2 (400);
BEGIN
  role := SYS_CONTEXT('USER_CTX','role');
  IF role = 'ADMIN18_ROLE_PARTICIPATE' THEN
    return_val := 'idUser=SYS_CONTEXT(''USER_CTX'',''idUser'')';
  ELSIF role = 'ADMIN18_ROLE_ORGANIZER' THEN
    return_val := 'idEvent IN (SELECT idEvent FROM ADMIN18.EVENTS WHERE idUser = SYS_CONTEXT(''UTI_CTX'',''idUser''))';
  ELSE
    return_val := '1=1';
  END IF;
  RETURN return_val;
END;
/

COMMIT;

/** ADMIN18 **/
INSERT INTO USERS VALUES('USER1','E165787P','admin1','admin1','Nantes','1111111111');

COMMIT;