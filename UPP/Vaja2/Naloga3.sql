USE master;

DROP DATABASE GlasbeniFestival;
CREATE DATABASE GlasbeniFestival;

USE GlasbeniFestival;
GO

CREATE TABLE Sponzor(
	id_sponzorja int IDENTITY(1, 1) PRIMARY KEY,
	naziv nvarchar(100) NOT NULL UNIQUE,
	davcna_stevilka char(8) UNIQUE,
	znesek money CHECK(znesek >= 500.00),
	datum_pogodbe date DEFAULT GETDATE()
);

CREATE TABLE Oder(
	id_odra int IDENTITY(1, 1) PRIMARY KEY,
	ime nvarchar(50) NOT NULL UNIQUE,
	kapaciteta int CHECK(kapaciteta BETWEEN 100 AND 20000),
	pokrit bit DEFAULT(0),
	id_sponzorja int FOREIGN KEY REFERENCES Sponzor(id_sponzorja)
);

CREATE TABLE Izvajalec(
	id_izvajalca int IDENTITY(1, 1) PRIMARY KEY,
	ime nvarchar(80) NOT NULL UNIQUE,
	zvrst varchar(15) NOT NULL CHECK(zvrst IN ('rock', 'pop', 'jazz', 'elektronika', 'folk')),
	drzava char(2) DEFAULT('SI'),
	honorar money CHECK(honorar >= 0)
);

CREATE TABLE Nastop(
	id_nastopa int IDENTITY(1, 1) PRIMARY KEY,
	id_izvajalca int NOT NULL FOREIGN KEY REFERENCES Izvajalec(id_izvajalca),
	id_odra int NOT NULL FOREIGN KEY REFERENCES Oder(id_odra),
	zacetek datetime NOT NULL,
	trajanje_min smallint DEFAULT(60) CHECK(trajanje_min BETWEEN 15 AND 180)
);

CREATE TABLE ClanSkupine(
	id_clana int IDENTITY(1, 1) PRIMARY KEY,
	ime_priimek nvarchar(80) NOT NULL,
	instrument nvarchar(30) DEFAULT('vokal'),
	starost tinyint CHECK(starost >= 16),
	id_izvajalca int NOT NULL FOREIGN KEY REFERENCES Izvajalec(id_izvajalca)
);