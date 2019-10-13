/** SCRIPT CREATION TABLE **/
DROP TABLE PARTICIPATES;
DROP TABLE EVENTS;
DROP TABLE USERS;

CREATE TABLE USERS (
  idUser varchar2(255),
  numberIdentification varchar2(255),
  lastname varchar2(255),
  firstname varchar2(255),
  address varchar2(255),
  phone varchar2(255),
  CONSTRAINT ADMIN18_PK_USERS PRIMARY KEY (idUser)
); 

CREATE TABLE EVENTS (
  idEvent varchar2(255),
  idUser varchar2(255),
  dateEvent varchar2(255),
  placeEvent varchar2(255),
  nameEvent varchar2(255),
  typeEvent varchar2(255),
  cost number(10),
  nbReservedScenes number(10),
  nbReservedBooth number(10),
  comments varchar2(255),
  CONSTRAINT ADMIN18_PK_EVENTS PRIMARY KEY (idEvent),
  CONSTRAINT ADMIN18_FK_EVENTS_USERS FOREIGN KEY (idUser)
  REFERENCES USERS (idUser)
);

CREATE TABLE PARTICIPATES (
  idEvent varchar2(255),
  idUser varchar2(255),
  dateRegistre varchar2(255),
  CONSTRAINT ADMIN18_PK_PARTICIPATES PRIMARY KEY (idEvent,idUser),
  CONSTRAINT ADMIN18_FK_PARTICIPATES_EVENTS FOREIGN KEY (idEvent)
  REFERENCES EVENTS(idEvent),
  CONSTRAINT ADMIN18_FK_PARTICIPATES_USERS FOREIGN KEY (idUser)
  REFERENCES USERS (idUser)
); 

DROP VIEW VUE_EVENTS;
CREATE VIEW VUE_EVENTS 
	AS SELECT idEvent,idUser,dateEvent,placeEvent,nameEvent,typeEvent 
	FROM EVENTS ;

COMMIT;
/**  FIN SCRIPT CREATION TABLE  **/

/** JEU ESSAI **/
INSERT INTO USERS VALUES('USER1','E165787P','admin1','admin1','Nantes','1111111111');
INSERT INTO USERS VALUES('USER2','E658790V','organizer2','organizer2','Lyon','2222222222');
INSERT INTO USERS VALUES('USER3','E348715H','organizer3','organizer3','Paris','3333333333');
INSERT INTO USERS VALUES('USER4','E238150J','participate4','participate4','Nantes','4444444444');
INSERT INTO USERS VALUES('USER5','E729478S','participate5','participate5','Nantes','5555555555');

INSERT INTO EVENTS VALUES('EVENT1','USER2','12/10/2019','PARIS','Soliday','Festif',24000,4,10,'Festival de musique');
INSERT INTO EVENTS VALUES('EVENT2','USER2','23/10/2019','PARIS','Activiste','Culturel',240000,6,31,'Festival polyculturel');
INSERT INTO EVENTS VALUES('EVENT3','USER3','15/10/2019','PARIS','CEO','Culturel',560000,23,54,'Festival de veille technologique');

INSERT INTO PARTICIPATES VALUES('EVENT1','USER5','07/10/2019');
INSERT INTO PARTICIPATES VALUES('EVENT2','USER5','07/10/2019');
INSERT INTO PARTICIPATES VALUES('EVENT1','USER4','07/10/2019');
INSERT INTO PARTICIPATES VALUES('EVENT2','USER4','07/10/2019');
INSERT INTO PARTICIPATES VALUES('EVENT3','USER4','07/10/2019');
INSERT INTO PARTICIPATES VALUES('EVENT3','USER5','07/10/2019');

COMMIT;
/** FIN JEU ESSAI **/