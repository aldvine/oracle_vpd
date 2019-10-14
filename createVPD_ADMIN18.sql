/** SCRIPT CREATION VPD */

/** CREATION POLICY POUR LA TABLE USERS */
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
/** FIN CREATION POLICY POUR LA TABLE USERS */

/** VPD SELECT ET UPDATE USERS **/
CREATE OR REPLACE FUNCTION auth_users(schema_var IN VARCHAR2,table_var IN VARCHAR2)
RETURN VARCHAR2
IS
  role VARCHAR2(400);
  return_val VARCHAR2 (400);
BEGIN
  role := SYS_CONTEXT('USER_CTX','role');
  IF role = 'ADMIN18_ROLE_PARTICIPATE' OR role = 'ADMIN18_ROLE_ORGANIZER' THEN
    return_val := 'idUser=SYS_CONTEXT(''USER_CTX'',''idUser'')';
  ELSE
    return_val := '1=1';
  END IF;
  RETURN return_val;
END;
/

COMMIT;
/** FIN VPD SELECT ET UPDATE USERS **/

/** CREATION POLICY POUR LA TABLE EVENTS */
BEGIN
  DBMS_RLS.DROP_POLICY ('ADMIN18','EVENTS','events_policy');
END;
/

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
/** FIN CREATION POLICY POUR LA TABLE EVENTS */

/** VPD SELECT,INSERT,UPDATE,DELETE EVENTS **/
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

COMMIT;
/** FIN VPD SELECT,INSERT,UPDATE,DELETE EVENTS **/

/** CREATION POLICY POUR LA TABLE PARTICIPATES */
BEGIN
  DBMS_RLS.DROP_POLICY ('ADMIN18','PARTICIPATES','participate_policy');
END;
/

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
/** FIN CREATION POLICY POUR LA TABLE PARTICIPATES */

/** VPD SELECT,INSERT,DELETE PARTICIPATES **/
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
/** FIN VPD SELECT,INSERT,DELETE PARTICIPATES **/