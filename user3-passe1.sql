/** USER3 **/
EXECUTE ADMIN18.set_user_ctx_pkg.set_user;
INSERT INTO ADMIN18.EVENTS VALUES('EVENT3','USER3','12/10/2019','PARIS','Soliday','Festif',24000,4,10,'Festival de musique');
INSERT INTO ADMIN18.EVENTS VALUES('EVENT4','USER3','23/10/2019','PARIS','Activiste','Culturel',240000,6,31,'Festival polyculturel');
INSERT INTO ADMIN18.EVENTS VALUES('EVENT5','USER3','15/10/2019','PARIS','CEO','Culturel',560000,23,54,'Festival de veille technologique');
INSERT INTO ADMIN18.EVENTS VALUES('EVENT6','USER3','25/10/2019','MARSEILLE','Tournoi de pétanque','Culturel/Sportif',50000,0,6,'Concour de pétanque');
INSERT INTO ADMIN18.EVENTS VALUES('EVENT7','USER3','04/11/2019','NANTES','Festival des plantes','Culturel/Exposition',6000,1,12,'Exposition de plante');
UPDATE ADMIN18.EVENTS SET dateEvent = '24/11/2019' WHERE idEvent = 'EVENT2';
SELECT * FROM ADMIN18.EVENTS;
DELETE FROM ADMIN18.EVENTS WHERE idEvent = 'EVENT2';
SELECT * FROM ADMIN18.EVENTS;
SELECT * FROM ADMIN18.PARTICIPATES;