/** USER2 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
/** Affichage du role */
SELECT SYS_CONTEXT('USER_CTX','role') FROM DUAL;

/** Test de la table ADMIN18.USERS */
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
DELETE FROM ADMIN18.USERS WHERE idUser = 'USER4';

/** Impossible d'insérer un user*/
INSERT INTO ADMIN18.USERS VALUES('USER8','E347987R','collectivity8','collectivity8','Lyon','8888888888');

/** Fin test de la table ADMIN18.USERS */

/** Test de la table ADMIN.EVENTS*/
/** Insertion des */
INSERT INTO ADMIN18.EVENTS VALUES('EVENT1','USER2','31/10/2019','NANTES','OctoberFest','Festif',120000,2,4,'Fête nantaise');
INSERT INTO ADMIN18.EVENTS VALUES('EVENT2','USER2','31/11/2019','LYON','DevFest','Culturel',40000,1,6,'Découverte des technologies');
/** */
INSERT INTO ADMIN18.EVENTS VALUES('EVENT1','USER2','31/10/2019','NANTES','OctoberFest','Festif',120000,2,4,'Fête nantaise');
INSERT INTO ADMIN18.EVENTS VALUES('EVENT2','USER2','31/11/2019','LYON','DevFest','Culturel',40000,1,6,'Découverte des technologies');
UPDATE ADMIN18.EVENTS SET dateEvent = '22/10/2019' WHERE idEvent = 'EVENT1';
SELECT * FROM ADMIN18.EVENTS;
DELETE FROM ADMIN18.EVENTS WHERE idEvent = 'EVENT1';
SELECT * FROM ADMIN18.EVENTS;
SELECT * FROM ADMIN18.PARTICPATES;