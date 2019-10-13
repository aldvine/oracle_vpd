/** USER2 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affichage du role */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Affiche seulement ces informations */
SELECT idEvent FROM ADMIN18.EVENTS;

/** Suppression des EVENTS*/
DELETE FROM ADMIN18.EVENTS;
COMMIT;
/** Impossible de supprimer un EVENT d'un autre User*/
DELETE FROM ADMIN18.EVENTS WHERE idUser = 'USER3';

/** Insertion des EVENTS*/
INSERT INTO ADMIN18.EVENTS VALUES('EVENT1','USER2','31/10/2019','NANTES','OctoberFest','Festif',120000,2,4,'Fête nantaise');
INSERT INTO ADMIN18.EVENTS VALUES('EVENT2','USER2','31/11/2019','LYON','DevFest','Culturel',40000,1,6,'Découverte des technologies');
COMMIT;

/** Impossible d'insérer un EVENT avec un autre idUser*/
INSERT INTO ADMIN18.EVENTS VALUES('EVENT999','USER3','31/11/2019','LYON','DevFest','Culturel',40000,1,6,'Découverte des technologies');

/** Modification des EVENTS*/
UPDATE ADMIN18.EVENTS SET dateEvent = '22/10/2019' WHERE idEvent = 'EVENT1';
COMMIT;
SELECT idEvent FROM ADMIN18.EVENTS;
/** Aucun changement sur les EVENTS des autres users*/
UPDATE ADMIN18.EVENTS SET dateEvent = '22/10/2019' WHERE idEvent = 'EVENT4';