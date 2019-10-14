/** USER1 */
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affiche le role de l'utilisateur */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Insertion de Users */
INSERT INTO ADMIN18.USERS VALUES('USER6','E452394P','participate6','participate6','Paris','6666666666');
INSERT INTO ADMIN18.USERS VALUES('USER7','E347987R','collectivity7','collectivity7','Lyon','7777777777');

COMMIT;

/** Affiche l'ensemble des utilisateurs qui ont été insérés*/
SELECT idUser FROM ADMIN18.USERS;

/** Possibilité de faire un update sur n'importe quel user*/
SELECT idUser,numberIdentification FROM ADMIN18.USERS;
UPDATE ADMIN18.USERS SET numberIdentification = 'TEST2' WHERE idUser = 'USER5';

COMMIT;

SELECT idUser,numberIdentification FROM ADMIN18.USERS;

/** Possibilité de supprimer n'importe quel USER*/
DELETE FROM ADMIN18.USERS WHERE idUser = 'USER7';

COMMIT;

SELECT idUser FROM ADMIN18.USERS;

INSERT INTO ADMIN18.USERS VALUES('USER7','E347987R','collectivity7','collectivity7','Lyon','7777777777');

COMMIT;