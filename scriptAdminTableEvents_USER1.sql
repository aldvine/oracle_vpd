/** USER1*/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affiche le role de l'utilisateur */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Insertion d'événement*/
SELECT idEvent,idUser FROM ADMIN18.EVENTS;
INSERT INTO EVENTS VALUES('EVENT4','USER3','12/10/2019','PARIS','Soliday','Festif',24000,4,10,'Festival de musique',0);
INSERT INTO EVENTS VALUES('EVENT5','USER3','23/10/2019','PARIS','Activiste','Culturel',240000,6,31,'Festival polyculturel',0);

COMMIT;
SELECT idEvent,idUser FROM ADMIN18.EVENTS;

/** Possibilité de faire un update sur n'importe quel EVENTS*/
SELECT idEvent,idUser,placeEvent FROM ADMIN18.EVENTS;
UPDATE ADMIN18.EVENTS SET placeEvent WHERE idEvent = 'EVENT4';
COMMIT;
SELECT idEvent,idUser,placeEvent FROM ADMIN18.EVENTS;

/** Impossible de supprimer un EVENTS*/
DELETE FROM ADMIN18.EVENTS WHERE idEvent = 'EVENT4';
COMMIT;
SELECT idEvent FROM ADMIN18.EVENTS;


