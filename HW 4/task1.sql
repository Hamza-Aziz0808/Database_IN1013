 DROP DATABASE IF EXISTS pet_database;
  CREATE DATABASE pet_database;
USE pet_database;
 DROP TABLE IF EXISTS petPet, petEvent;
Up to the next CUTOFF POINT should be in task1.sql

CREATE TABLE petPet (
  petname VARCHAR(20) NOT NULL,
  owner VARCHAR(45),
  species VARCHAR(45),
  gender CHAR(1) CHECK (gender IN ('M', 'F')),
  birth DATE,
  death DATE,
  PRIMARY KEY (PETNAME)
);

??? petEvent (
  petname VARCHAR(20),
  eventdate DATE,
  eventtype VARCHAR(20),
  remark VARCHAR(20),
  FOREIGN KEY (petname, eventdate, eventtype),
  PRIMARY KEY (petname) REFRENCES petPet(petname)
);
|DESC petPet
