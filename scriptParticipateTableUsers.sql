/** USER4 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affichage du role */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Affiche seulement ces informations */
SELECT idUser FROM ADMIN18.USERS;

/** Impossible de changer le numero Identification d'un autre user */
UPDATE ADMIN18.USERS SET numberIdentification = 'TEST' WHERE idUser = 'USER3';

SELECT idUser, numberIdentification FROM ADMIN18.USERS;
/** Possible de changer ces infos*/
UPDATE ADMIN18.USERS SET numberIdentification = 'TEST';

COMMIT;

/** Affiche le changement du numberIndentification*/
SELECT idUser, numberIdentification FROM ADMIN18.USERS;

/** Impossible de supprimer un user */
DELETE FROM ADMIN18.USERS WHERE idUser = 'USER3';

/** Impossible d'insérer un user*/
INSERT INTO ADMIN18.USERS VALUES('USER8','E347987R','collectivity8','collectivity8','Lyon','8888888888');
