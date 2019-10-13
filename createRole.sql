/** SCRIPT CREATION ROLE **/
DROP ROLE ADMIN18_ROLE_ADMIN;
DROP ROLE ADMIN18_ROLE_COLLECTIVITY;
DROP ROLE ADMIN18_ROLE_ORGANIZER;
DROP ROLE ADMIN18_ROLE_PARTICIPATE;
CREATE ROLE ADMIN18_ROLE_ADMIN;
CREATE ROLE ADMIN18_ROLE_COLLECTIVITY;
CREATE ROLE ADMIN18_ROLE_ORGANIZER;
CREATE ROLE ADMIN18_ROLE_PARTICIPATE;

COMMIT;
/** FIN SCRIPT CREATION ROLE **/


/** SCRIPT CREATION PRIVILEGE POUR LES ROLES **/
/** Affectation des droits pour le role COLLECTIVITY */
GRANT SELECT ON VUE_EVENTS TO ADMIN18_ROLE_COLLECTIVITY;
GRANT SELECT ON PARTICIPATES TO ADMIN18_ROLE_COLLECTIVITY;

/** Affectation des droits pour le role PARTICIPATE */
GRANT ADMIN18_ROLE_COLLECTIVITY TO ADMIN18_ROLE_PARTICIPATE;
GRANT SELECT,UPDATE(lastname,firstname,address,phone) ON USERS TO ADMIN18_ROLE_PARTICIPATE;
GRANT INSERT,DELETE ON PARTICIPATES TO ADMIN18_ROLE_PARTICIPATE;

/** Affectation des droits pour le role ORGANIZER */
GRANT ADMIN18_ROLE_COLLECTIVITY TO ADMIN18_ROLE_ORGANIZER;
GRANT SELECT,UPDATE(lastname,firstname,address,phone) ON USERS TO ADMIN18_ROLE_ORGANIZER;
GRANT SELECT,UPDATE,INSERT,DELETE ON EVENTS TO ADMIN18_ROLE_ORGANIZER;
GRANT SELECT ON PARTICIPATES TO ADMIN18_ROLE_ORGANIZER;

/** Affectation des droits pour le role ADMIN */
GRANT SELECT,INSERT,UPDATE,DELETE ON USERS TO ADMIN18_ROLE_ADMIN;
GRANT SELECT,INSERT,UPDATE,DELETE ON EVENTS TO ADMIN18_ROLE_ADMIN;
GRANT SELECT,INSERT,UPDATE,DELETE ON VUE_EVENTS TO ADMIN18_ROLE_ADMIN;

COMMIT;
/** FIN SCRIPT CREATION PRIVILEGE POUR LES ROLES **/

/** SCRIPT AFFECTATION PRIVILEGE AUX USERS */
GRANT ADMIN18_ROLE_ADMIN TO USER1;
GRANT ADMIN18_ROLE_ORGANIZER TO USER2;
GRANT ADMIN18_ROLE_ORGANIZER TO USER3;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER4;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER5;
GRANT ADMIN18_ROLE_PARTICIPATE TO USER6;
GRANT ADMIN18_ROLE_COLLECTIVITY TO USER7;

COMMIT;
/** FIN SCRIPT AFFECTATION PRIVILEGE AUX USERS */


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

GRANT EXECUTE ON set_user_ctx_pkg.set_user TO USER1;
GRANT EXECUTE ON set_user_ctx_pkg.set_user TO USER2;
GRANT EXECUTE ON set_user_ctx_pkg.set_user TO USER3;
GRANT EXECUTE ON set_user_ctx_pkg.set_user TO USER4;
GRANT EXECUTE ON set_user_ctx_pkg.set_user TO USER5;
GRANT EXECUTE ON set_user_ctx_pkg.set_user TO USER6;
GRANT EXECUTE ON set_user_ctx_pkg.set_user TO USER7;

COMMIT;
/** FIN SCRIPT CREATION CONTEXT APPLICATION */