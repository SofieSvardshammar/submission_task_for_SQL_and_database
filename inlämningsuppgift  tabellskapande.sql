-- Skapa en databas om den existerar, uppdatera och anv�nd databas
USE [master];

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'inl�mning')
BEGIN
  DROP DATABASE inl�mning;
END;

CREATE DATABASE inl�mning;
GO

USE [inl�mning];
GO

-- TILLVERKARE Skapa tabeller och f�r in v�rden, denna har ingen foreign key eftersom man ska b�rja med de som inte har det.(parent-tabell)
CREATE TABLE tillverkare (
	tillverkare VARCHAR (25) PRIMARY KEY,
	specialomr�de VARCHAR (25) NOT NULL,
	kontaktperson VARCHAR (25) DEFAULT NULL,
	telefonnummer VARCHAR (25) NOT NULL,
	land VARCHAR (25) DEFAULT NULL
);
-- l�gger till v�rden i tabellen
INSERT INTO tillverkare(tillverkare, specialomr�de, kontaktperson, telefonnummer, land) VALUES ('Scanda Audi motors', 'Audimotorer', NULL, '+438850234', 'Damnark');
INSERT INTO tillverkare(tillverkare, specialomr�de, kontaktperson, telefonnummer, land) VALUES ('Automobil SLK', 'cylindrar', 'Frans Shulser', '+478937522', 'Tyskland');
INSERT INTO tillverkare(tillverkare, specialomr�de, kontaktperson, telefonnummer, land) VALUES ('Die decken firmen', 'd�ck', NULL, '+47233789784', 'Tyskland');
INSERT INTO tillverkare(tillverkare, specialomr�de, kontaktperson, telefonnummer, land) VALUES ('Norrlands d�ck', 'd�ck till Motorla', 'Klas Malm', '028850234', 'Sverige');
INSERT INTO tillverkare(tillverkare, specialomr�de, kontaktperson, telefonnummer, land) VALUES ('Skrachna automobil', 'polering & Interi�r', NULL, '+446493728', 'Polen');


-- AVDELNING. Denna tabell har heller ingen foreign key. Detta �r ocks� en parent-tabell
CREATE TABLE avdelning (
	avdelnings_id INT PRIMARY KEY,
	omr�de VARCHAR (25) DEFAULT NULL,
	antal_anst�llda INT DEFAULT NULL,
	int�kter INT DEFAULT NULL,
	antal_servrade_bilar_2021 INT DEFAULT NULL
);
-- l�gger till v�rden i tabellen
INSERT INTO avdelning(avdelnings_id, omr�de, antal_anst�llda, int�kter, antal_servrade_bilar_2021) VALUES (1, 'D�ckbyte', 18, 8850234, 2950);
INSERT INTO avdelning(avdelnings_id, omr�de, antal_anst�llda, int�kter, antal_servrade_bilar_2021) VALUES (2, 'Motorer', 14, 7902700, 2634);
INSERT INTO avdelning(avdelnings_id, omr�de, antal_anst�llda, int�kter, antal_servrade_bilar_2021) VALUES (3, 'Bakhjulscylindrar', 27, 6819034, 2273);
INSERT INTO avdelning(avdelnings_id, omr�de, antal_anst�llda, int�kter, antal_servrade_bilar_2021) VALUES (4, 'Lack och polering',31, 5631220, 1877);
INSERT INTO avdelning(avdelnings_id, omr�de, antal_anst�llda, int�kter, antal_servrade_bilar_2021) VALUES (5, 'Interi�r', 16, 4701040, 1562);

-- BEST�LLDA DELAR. Denna tabell har en foreign key fr�n tabellen tillverkare, en child-tabell, men det �r ocks� en parent-tabell till bil�gardelar
CREATE TABLE best�llda_delar (
	order_id INT NOT NULL PRIMARY KEY,
	produkt VARCHAR (40) DEFAULT NULL,
	antal INT DEFAULT NULL,
	tillverkare VARCHAR (25) NOT NULL,
	orderdatum DATETIME NOT NULL,
	pris INT NOT NULL,
	FOREIGN KEY (tillverkare) REFERENCES tillverkare (tillverkare) ON DELETE CASCADE ON UPDATE CASCADE
);
-- l�gger till v�rden i tabellen
INSERT INTO best�llda_delar(order_id, produkt, antal, tillverkare, orderdatum, pris) VALUES (1, '323d d�ck', 4,'Die decken firmen', '2022-03-01 10:30:30', 7200);
INSERT INTO best�llda_delar(order_id, produkt, antal, tillverkare, orderdatum, pris) VALUES (2, '353 motordel', 3,'Scanda Audi motors', '2022-03-01 10:35:30', 6300);
INSERT INTO best�llda_delar(order_id, produkt, antal, tillverkare, orderdatum, pris) VALUES (3, '4391L d�ck', 2,'Die decken firmen', '2022-12-01 15:45:02',4700);
INSERT INTO best�llda_delar(order_id, produkt, antal, tillverkare, orderdatum, pris) VALUES (4, 'cylinder 34K', 4,'Automobil SLK', '2022-11-03 11:04:12', 5600);
INSERT INTO best�llda_delar(order_id, produkt, antal, tillverkare, orderdatum, pris) VALUES (5, 'frams�tesdel h�ger32', 4,'Skrachna automobil', '2022-09-11 09:16:10', 1800);

-- ANST�LLDA. denna tabell har en foerign key fr�n tabellen avdelning, den sammanslagna kolumnen �r avdelnings_id. Detta �r en child-tabell  
CREATE TABLE anst�llda (
	anst�llnings_id INT PRIMARY KEY,
	f�rnamn VARCHAR (40) DEFAULT NULL,
	efternamn VARCHAR (40) DEFAULT NULL,
	anst�llningsdatum DATE NOT NULL,
	l�n INT NOT NULL,
	k�n CHAR (1) NOT NULL,
	avdelnings_id INT NOT NULL,
	FOREIGN KEY (avdelnings_id) REFERENCES avdelning (avdelnings_id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- l�gger till v�rden i tabellen
INSERT INTO anst�llda(anst�llnings_id, f�rnamn, efternamn, anst�llningsdatum, l�n, k�n, avdelnings_id) VALUES (1, 'Karl', 'Persson', '2018-03-01', 538200, 'M', 3);
INSERT INTO anst�llda(anst�llnings_id, f�rnamn, efternamn, anst�llningsdatum, l�n, k�n, avdelnings_id) VALUES (2, 'Jakob', 'Karlsson', '2018-04-23', 750300, 'M', 5);
INSERT INTO anst�llda(anst�llnings_id, f�rnamn, efternamn, anst�llningsdatum, l�n, k�n, avdelnings_id) VALUES (3, 'Lena', 'Fredrisksson', '2013-07-15', 854800, 'K', 3);
INSERT INTO anst�llda(anst�llnings_id, f�rnamn, efternamn, anst�llningsdatum, l�n, k�n, avdelnings_id) VALUES (4, 'Josef', 'Hadarsson', '2022-06-30', 405000, 'M', 2);
INSERT INTO anst�llda(anst�llnings_id, f�rnamn, efternamn, anst�llningsdatum, l�n, k�n, avdelnings_id) VALUES (5, 'Jesper', 'Lund', '2022-05-01', 773000, 'M', 1);

-- BIL�GARE. Denna tabell har en foreign key,fr�n avdelning. Det g�r denna tabell till en child-tabell men det �r ocks� en parent-tabell till bil�gardelar
CREATE TABLE bil�gare (
	registreringsnummer VARCHAR(6) NOT NULL PRIMARY KEY,
	f�rnamn VARCHAR (40) DEFAULT NULL,
	efternamn VARCHAR (40) DEFAULT NULL,
	telefonnummer VARCHAR (20) DEFAULT NULL,
	avdelnings_id INT NOT NULL,
	FOREIGN KEY (avdelnings_id) REFERENCES avdelning (avdelnings_id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- l�gger till v�rden i tabellen
INSERT INTO bil�gare(registreringsnummer, f�rnamn, efternamn, telefonnummer, avdelnings_id) VALUES ('MDK265','Lars', 'Hellbom', 0743883475, 1);
INSERT INTO bil�gare(registreringsnummer, f�rnamn, efternamn, telefonnummer, avdelnings_id) VALUES ('YHY782','Hanna', 'Svensson', 0733875512, 3); 
INSERT INTO bil�gare(registreringsnummer, f�rnamn, efternamn, telefonnummer, avdelnings_id) VALUES ('OMD153', 'Harald', 'Lindros', 0737621197, 2);
INSERT INTO bil�gare(registreringsnummer, f�rnamn, efternamn, telefonnummer, avdelnings_id) VALUES ('HEI322', 'Mikael', 'Forslund', 0737542678, 1);
INSERT INTO bil�gare(registreringsnummer, f�rnamn, efternamn, telefonnummer, avdelnings_id) VALUES ('IKR244', 'Jimmy', 'Brant', 0707073445, 4);

-- Sist sammanfogar jag many-to-many tabellerna bil�gare och best�llda_delar till denna tabell. Detta �r en childtabell till dessa.
-- Foreign keys �r registreringsnummer fr�n bil�gare samt order_id fr�n best�llda delar.
CREATE TABLE bil�gardelar (
	id INT PRIMARY KEY,
	registreringsnummer VARCHAR(6) NOT NULL,
	order_id INT NOT NULL,
	FOREIGN KEY (registreringsnummer) REFERENCES bil�gare (registreringsnummer) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (order_id) REFERENCES best�llda_delar (order_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- l�gger till v�rden i tabellen
INSERT INTO bil�gardelar(id, registreringsnummer, order_id) VALUES (1,'HEI322', 1);
INSERT INTO bil�gardelar(id, registreringsnummer, order_id) VALUES (2,'MDK265', 2);
INSERT INTO bil�gardelar(id, registreringsnummer, order_id) VALUES (3,'HEI322', 3);
INSERT INTO bil�gardelar(id, registreringsnummer, order_id) VALUES (4,'OMD153', 1);
INSERT INTO bil�gardelar(id, registreringsnummer, order_id) VALUES (5,'YHY782', 5);

-- SE LISTORNA
SELECT * FROM avdelning;
SELECT * FROM anst�llda;
SELECT * FROM bil�gare;
SELECT * FROM tillverkare;
SELECT * FROM best�llda_delar;
SELECT * FROM bil�gardelar;

-- Visa allt fr�n en kolumn.
SELECT bil�gare.f�rnamn FROM bil�gare;

-- Visar alla p� avdelning 3 samt alla som har f�rnamn 'Jakob'.
SELECT * FROM anst�llda WHERE avdelnings_id = 3 OR f�rnamn = 'Jakob';

-- Anst�llda som fick jobb i mars, datums�kning
SELECT * FROM anst�llda
WHERE anst�llningsdatum LIKE '____-03%';

-- S�k efter alla NULL i en specifik tabell
SELECT * FROM tillverkare WHERE kontaktperson IS NULL;

-- Man anv�nder BETWEEN f�r att visa det som finns mellan 2 bes�mda v�rden.
SELECT * FROM avdelning
WHERE antal_servrade_bilar_2021
BETWEEN '2000' AND '3000';

-- Aggregate-funktioner anv�nds f�r r�kning, h�r �r den totala summan av alla l�ner
SELECT SUM (l�n) AS Total_l�n FROM anst�llda;

-- Medelv�rdet av int�ckter f�r de olika avdelningarna
SELECT AVG (int�kter) FROM avdelning;

-- Ordna efter l�n
SELECT * FROM anst�llda
ORDER BY l�n DESC;

-- TOP v�ljer att visa (i detta fall) 2 rader.
SELECT TOP 2 *
FROM anst�llda;

--R�kna ihop allas l�ner f�r de anst�llda
SELECT f�rnamn, efternamn, l�n,
SUM(l�n) OVER (ORDER BY l�n RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_l�n
FROM anst�llda;

-- Hur m�nga m�n respektive kvinnor finns det
SELECT COUNT (k�n), k�n FROM anst�llda
GROUP BY k�n;

--INNER JOIN F�r med allt som st�mmer �verrens med de olika tabellerna
SELECT * FROM avdelning INNER JOIN anst�llda
ON avdelning.avdelnings_id=anst�llda.avdelnings_id

--LEFT JOIN
SELECT * FROM avdelning LEFT JOIN anst�llda
ON avdelning.avdelnings_id=anst�llda.avdelnings_id

--Skapa en variabel och fyll p� med ett v�rde
DECLARE @regg_nr VARCHAR(6);
SET @regg_nr='IKR244';

-- S�k med en variabel, f�rst skapar man en variabel med det v�rdet jag s�ker, sen v�ljer man var man vill s�ka
DECLARE @regg_nr VARCHAR(6);
SET @regg_nr='IKR244';
SELECT * FROM bil�gare
WHERE registreringsnummer = @regg_nr;

-- L�gg till en kolumn i en tabell
ALTER TABLE bil�gare
ADD adress VARCHAR(50);

-- Ta bort en rad
Delete FROM bil�gare WHERE registreringsnummer = 'IKR244';

-- Byt namn p� en tabell
EXEC sp_rename 'bil�gare', 'Kund';