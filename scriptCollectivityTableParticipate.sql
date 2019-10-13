/** USER4 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affichage du role */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Affiche l'ensemble des participations */
SELECT * FROM ADMIN18.PARTICPATES;

/** Impossible de supprimer les participations*/
DELETE FROM ADMIN18.PARTICIPATES WHERE idUser = 'USER5';

/** Impossible d'insérer des participations*/
INSERT INTO PARTICIPATES VALUES('EVENT1','USER6','07/10/2019');

/** Impossible de modifier des participations */
UPDATE ADMIN18.PARTICIPATES SET idUser = 'USER3' WHERE idEvent = 'EVENT2';
