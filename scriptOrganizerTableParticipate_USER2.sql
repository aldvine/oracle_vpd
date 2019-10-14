/** USER2 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affichage du role */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Affiche seulement ces informations */
SELECT * FROM ADMIN18.PARTICPATES;

/** Impossible d'insérer des participations */
INSERT INTO ADMIN18.PARTICIPATES VALUES('EVENT2','USER2','07/10/2019');

/** Impossible de modifier des participations */
UPDATE ADMIN18.PARTICIPATES SET idUser = 'USER3' WHERE idEvent = 'EVENT2';

/** Impossible de supprimer des participations */
DELETE FROM ADMIN18.PARTICIPATES WHERE idEvent = 'EVENT2';