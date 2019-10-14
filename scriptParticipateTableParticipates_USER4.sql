/** USER4 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affichage du role */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Affiche seulement ces informations */
SELECT * FROM ADMIN18.PARTICIPATES;

/** Supprimer des participations */
DELETE FROM ADMIN18.PARTICIPATES;
COMMIT;
/** Impossible de supprimer les participations d'un autre user*/
DELETE FROM ADMIN18.PARTICIPATES WHERE idUser = 'USER5';

/** Insertion des participations */
INSERT INTO ADMIN18.PARTICIPATES VALUES('EVENT10','USER4','07/10/2019');
INSERT INTO ADMIN18.PARTICIPATES VALUES('EVENT11','USER4','07/10/2019');
COMMIT;

/** Impossible d'insérer des participations d'un autre User*/
INSERT INTO ADMIN18.PARTICIPATES VALUES('EVENT1','USER6','07/10/2019');

/** Impossible de modifier des participations */
UPDATE ADMIN18.PARTICIPATES SET dateRegistre = '10/10/2010' WHERE idEvent = 'EVENT2';

