/** SCRIPT CREATION TABLE **/

DROP TABLE `ADMIN18_USER`;

CREATE TABLE `ADMIN18_USER` (
  `idUser` varchar2(255),
  `numberIdentification` varchar2(255),
  `lastname` varchar2(255),
  `firstname` varchar2(255),
  `address` varchar2(255),
  `phone` varchar2(255),
 c PRIMARY KEY (`idUser`)
) 
DROP TABLE `ADMIN18_EVENT`;

CREATE TABLE `ADMIN18_EVENT` (
  `idEvent` varchar2(255),
  `idUser` varchar2(255),
  `lastname` varchar2(255),
  `firstname` varchar2(255),
  `address` varchar2(255),
  `phone` varchar2(255),
   CONSTRAINT ADMIN18_PK_EVENT PRIMARY KEY (`idEvent`,`idUser`),
  CONSTRAINT ADMIN18_FK_EVENT_USER FOREIGN KEY (idUser)
  REFERENCES ADMIN18_USER (column1, column2, ... column_n)
  
) 
DROP TABLE `ADMIN18_USERS`;

CREATE TABLE `ADMIN18_USERS` (
  `idUser` varchar2(255),
  `numberIdentification` varchar2(255),
  `lastname` varchar2(255),
  `firstname` varchar2(255),
  `address` varchar2(255),
  `phone` varchar2(255),
  PRIMARY KEY (`idUser`)
) 

/** SCRIPT CREATION ROLE **/
CREATE ROLE ROLE_ADMIN;
CREATE ROLE ROLE_COLLECTIVITY;
CREATE ROLE ROLE_ORGANIZER;
CREATE ROLE ROLE_PARTICIPATE;

/** SCRIPT CREATION PRIVILEGE POUR LES ROLES **/
GRANT ROLE_SESSION TO ROLE_ADMIN,ROLE_COLLECTIVITY;
GRANT ALL ON ADMIN18_USER TO ROLE_AMDIN WIT

