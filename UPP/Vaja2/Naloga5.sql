USE master;

DROP DATABASE IzposojaKoles;
CREATE DATABASE IzposojaKoles;

USE IzposojaKoles;
GO

CREATE TABLE Postaja(
	id_postaje int IDENTITY(1, 1) PRIMARY KEY,
	ime nvarchar(60) NOT NULL UNIQUE,
	naslov nvarchar(100) NOT NULL,
	st_mest tinyint NOT NULL CHECK(st_mest BETWEEN 5 AND 40),
	aktivna bit DEFAULT(1)
);

CREATE TABLE Kolo(
	id_kolesa int IDENTITY(1, 1) PRIMARY KEY,
	serijska_stevilka char(10) NOT NULL UNIQUE,
	tip varchar(12) DEFAULT('mestno') CHECK(tip IN ('mestno', 'elektricno', 'gorsko')),
	datum_nabave date DEFAULT GETDATE(),
	id_postaje int FOREIGN KEY REFERENCES Postaja(id_postaje)
);

CREATE TABLE Uporabnik(
	id_uporabnika int IDENTITY(1, 1) PRIMARY KEY,
	uporabnisko_ime varchar(30) NOT NULL UNIQUE,
	email varchar(100) NOT NULL UNIQUE,
	dobroimetje money DEFAULT(0) CHECK(dobroimetje >= 0),
	leto_rojstva smallint CHECK(leto_rojstva BETWEEN 1930 AND 2012)
);

CREATE TABLE Izposoja(
	id_izposoje int IDENTITY(1, 1) PRIMARY KEY,
	id_kolesa int NOT NULL FOREIGN KEY REFERENCES Kolo(id_kolesa),
	id_uporabnika int NOT NULL FOREIGN KEY REFERENCES Uporabnik(id_uporabnika),
	cas_zacetka datetime NOT NULL DEFAULT GETDATE(),
	cas_konca datetime,
	CHECK(cas_konca > cas_zacetka)
);

CREATE TABLE Okvara(
	id_okvare int IDENTITY(1, 1) PRIMARY KEY,
	id_kolesa int NOT NULL FOREIGN KEY REFERENCES Kolo(id_kolesa),
	opis nvarchar(255) NOT NULL,
	cas_prijave datetime DEFAULT GETDATE(),
	resena bit DEFAULT(0)
);