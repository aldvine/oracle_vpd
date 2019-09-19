/** SCRIPT CREATION TABLE **/

DROP TABLE 'USER';

CREATE TABLE 'USER' (
  'idUser' varchar2(255),
  'numberIdentification' varchar2(255),
  'lastname' varchar2(255),
  'firstname' varchar2(255),
  'address' varchar2(255),
  'phone' varchar2(255),
  CONSTRAINT PK_EVENT PRIMARY KEY ('idUser')
); 
DROP TABLE 'EVENT';

CREATE TABLE 'EVENT' (
  'idEvent' varchar2(255),
  'idUser' varchar2(255),
  'dateEvent' varchar2(255),
  'placeEvent' varchar2(255),
  'nameEvent' varchar2(255),
  'typeEvent' varchar2(255),
  'cost' number(10),
  'nbReservedScenes' number(10),
  'nbReservedBooth' number(10),
  'comment' varchar2(255),
  CONSTRAINT PK_EVENT PRIMARY KEY ('idEvent','idUser'),
  CONSTRAINT FK_EVENT_USER FOREIGN KEY ('idUser')
  REFERENCES USER ('idUser')
); 
DROP TABLE 'PARTICIPATE';

CREATE TABLE 'PARTICIPATE' (
  'idEvent' varchar2(255),
  'idUser' varchar2(255),
  'dateRegistre' varchar2(255),,
  CONSTRAINT PK_PARTICIPATE PRIMARY KEY ('idEvent','idUser'),
  CONSTRAINT FK_PARTICIPATE_EVENT FOREIGN KEY ('idEvent')
  REFERENCES EVENT ('idEvent'),
  CONSTRAINT FK_PARTICIPATE_USER FOREIGN KEY ('idUser')
  REFERENCES USER ('idUser')
); 

DROP VUE_EVENT;
CREATE VIEW VUE_EVENT 
	AS SELECT 'idEvent','idUser','dateEvent','placeEvent','nameEvent','typeEvent' 
	FROM EVENT ;

/**  FIN SCRIPT CREATION TABLE  **/

/** SCRIPT CREATION ROLE **/
CREATE ROLE ADMIN18_ROLE_ADMIN;
CREATE ROLE ADMIN18_ROLE_COLLECTIVITY;
CREATE ROLE ADMIN18_ROLE_ORGANIZER;
CREATE ROLE ADMIN18_ROLE_PARTICIPATE;
/** FIN SCRIPT CREATION ROLE **/


/** SCRIPT CREATION PRIVILEGE POUR LES ROLES **/
GRANT SELECT FROM VUE_EVENT TO ADMIN18_ROLE_COLLECTIVITY;
GRANT SELECT FROM PARTICIPATE TO ADMIN18_ROLE_COLLECTIVITY;

GRANT ADMIN18_ROLE_COLLECTIVITY TO ADMIN18_ROLE_PARTICIPATE;
GRANT SELECT,UPDATE(lastname,firstname,address,phone) FROM USER TO ADMIN18_ROLE_PARTICIPATE;
GRANT INSERT,DELETE FROM PARTICIPATE TO ADMIN18_ROLE_PARTICIPATE;

GRANT ADMIN18_ROLE_COLLECTIVITY TO ADMIN18_ROLE_ORANIZER;
GRANT SELECT,UPDATE(lastname,firstname,address,phone) FROM USER TO ADMIN18_ROLE_ORGANIZER;
GRANT SELECT,UPDATE,INSERT,DELETE FROM EVENT TO ADMIN18_ROLE_ORGANIZER;
GRANT SELECT FROM PARTICIPATE TO ADMIN18_ROLE_ORGANIZER;

GRANT SELECT,INSERT,UPDATE,DELETE FROM USER TO ADMIN18_ROLE_ADMIN WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE,DELETE FROM EVENT TO ADMIN18_ROLE_ADMIN WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE,DELETE FROM VUE_EVENT TO ADMIN18_ROLE_ADMIN WITH GRANT OPTION;
/** FIN SCRIPT CREATION PRIVILEGE POUR LES ROLES **/

/**  SCRIPT JEU ESSAI **/
GRANT ADMIN18_ROLE_ADMIN TO USER1;
GRANT ADMIN18_ROLE_ORGANIZER TO USER2;
GRANT ADMIN18_ROLE_ORGANIZER TO USER3;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER4;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER5;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER6;
GRANT ADMIN18_ROLE_COLLECTIVITY TO USER7;

/**  FIN SCRIPT JEU ESSAI **/

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