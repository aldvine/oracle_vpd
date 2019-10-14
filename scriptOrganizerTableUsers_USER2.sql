/** USER2 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affichage du role */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Affiche seulement ces informations */
SELECT idUser FROM ADMIN18.USERS;

/** Impossible de changer le numero de téléphone d'un autre user */
UPDATE ADMIN18.USERS SET phone = '9999999999' WHERE idUser = 'USER3';

/** Impossible de changer le numero Identification */
UPDATE ADMIN18.USERS SET numberIdentification = 'TEST';

SELECT idUser, numberIdentification FROM ADMIN18.USERS;

/** Possible de changer ces infos*/
UPDATE ADMIN18.USERS SET phone = '9999999999';

COMMIT;

/** Affiche le changement du numberIndentification*/
SELECT idUser, phone FROM ADMIN18.USERS;

/** Impossible de supprimer un user */
DELETE FROM ADMIN18.USERS WHERE idUser = 'USER4';

/** Impossible d'insérer un user*/
INSERT INTO ADMIN18.USERS VALUES('USER8','E347987R','collectivity8','collectivity8','Lyon','8888888888');
