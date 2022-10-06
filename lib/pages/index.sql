CREATE TABLE Movies
(
    title VARCHAR2(200),
    director VARCHAR2(50),
    myear NUMBER(10),
    rating NUMBER(3,2),
    PRIMARY KEY(title)
);

CREATE TABLE Actors
(
actor VARCHAR2(50),
ayear NUMBER(10),
PRIMARY KEY(actor)
);

CREATE TABLE Acts
(
    actor VARCHAR2(50),
    title VARCHAR2(200),
    FOREIGN KEY(actor) REFERENCES Actors(actor) ON DELETE CASCADE,
    FOREIGN KEY(title)REFERENCES Movies(title) ON DELETE CASCADE
);

CREATE TABLE Directors
(
director VARCHAR2(50),
dyear NUMBER(10),
PRIMARY KEY(director)
);

INSERT INTO Movies(title,director,myear,rating) VALUES('Fargo','Coen',1996.);
INSERT INTO Movies(title,director,myear,rating) VALUES('Raising Arizona','Coen',1987,7.6);
INSERT INTO Movies(title,director,myear,rating) VALUES('Spiderman','Raimi',2002,7.4);
INSERT INTO Movies(title,director,myear,rating) VALUES('Wonder Boys','Hanson',1996,7.6);

INSERT INTO Actors(actor,ayear) VALUES('Cage',1964);
INSERT INTO Actors(actor,ayear) VALUES('Hanks',1956);
INSERT INTO Actors(actor,ayear) VALUES('Maguire',1975);
INSERT INTO Actors(actor,ayear) VALUES('McDormand',1957);

INSERT INTO Acts(actor,title) VALUES('Cage','Raising Arizona');
INSERT INTO Acts(actor,title) VALUES('Maguire','Spiderman');
INSERT INTO Acts(title,) VALUES('Maguire','Wonder Boys');
INSERT INTO Acts(actor,title) VALUES('McDormand','Fargo');
INSERT INTO Acts(actor,title) VALUES('McDormand','Raising Arizona');
INSERT INTO Acts(actor,title) VALUES('McDormand','Wonder Boys');

INSERT INTO Directors(director,dyear) VALUES('Coen',1954);
INSERT INTO Directors(director,dyear) VALUES('Hanson',1945);
INSERT INTO Directors(director,dyear) VALUES('Raimi',1959);

SELECT director, rating from Movies WHERE year>1995;

SELECT a.actor, m.title from Acts a
Inner JOIN Movies m ON a.title = m.title AND m.director ='Coen';