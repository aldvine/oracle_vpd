/** USER1 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affiche le role de l'utilisateur */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;
INSERT INTO ADMIN18.USERS VALUES('USER2','E658790V','organizer2','organizer2','Lyon','2222222222');
INSERT INTO ADMIN18.USERS VALUES('USER3','E348715H','organizer3','organizer3','Paris','3333333333');
INSERT INTO ADMIN18.USERS VALUES('USER4','E238150J','participate4','participate4','Nantes','4444444444');
INSERT INTO ADMIN18.USERS VALUES('USER5','E729478S','participate5','participate5','Nantes','5555555555');
INSERT INTO ADMIN18.USERS VALUES('USER6','E452394P','participate6','participate6','Paris','6666666666');
INSERT INTO ADMIN18.USERS VALUES('USER7','E347987R','collectivity7','collectivity7','Lyon','7777777777');

COMMIT;

/** Affiche l'ensembele des utilisateurs qui ont été insérés*/
SELECT idUser FROM ADMIN18.USERS;

/** Possibilité de faire un update sur n'importe quel user*/
UPDATE ADMIN18.USERS SET numberIdentification = 'TEST2' WHERE idUser = "USER5";

COMMIT;

SELECT idUser,numberIdentification FROM ADMIN18.USERS;

/** Possibilité de supprimer n'importe quel USER*/
DELETE FROM ADMIN18.USERS WHERE idUser = 'USER3';

COMMIT;

SELECT idUser FROM ADMIN18.USERS;

INSERT INTO ADMIN18.USERS VALUES('USER3','E348715H','organizer3','organizer3','Paris','3333333333');

COMMIT;