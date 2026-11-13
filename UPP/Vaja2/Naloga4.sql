USE master;

DROP DATABASE PicerijaDostava;
CREATE DATABASE PicerijaDostava;

USE PicerijaDostava;
GO

CREATE TABLE Jed(
	id_jedi int IDENTITY(1, 1) PRIMARY KEY,
	naziv nvarchar(60) NOT NULL UNIQUE,
	kategorija varchar(15) NOT NULL CHECK(kategorija IN ('pica', 'testenine', 'solata', 'sladica', 'pijaca')),
	cena money NOT NULL CHECK(cena > 0),
	na_voljo bit DEFAULT(1)
);

CREATE TABLE Stranka(
	id_stranke int IDENTITY(1, 1) PRIMARY KEY,
	ime_priimek nvarchar(80) NOT NULL,
	telefon varchar(15) NOT NULL UNIQUE,
	naslov nvarchar(120) NOT NULL,
	cas_registracije datetime DEFAULT GETDATE()
);

CREATE TABLE Dostavljalec(
	id_dostavljalca int IDENTITY(1, 1) PRIMARY KEY,
	ime_priimek nvarchar(80) NOT NULL,
	telefon varchar(15) NOT NULL UNIQUE,
	vozilo varchar(10) DEFAULT('skuter') CHECK(vozilo IN ('kolo', 'skuter', 'avto')),
	ocena decimal(2, 1) CHECK(ocena BETWEEN 1.0 AND 5.0)
);

CREATE TABLE Narocilo(
	id_narocila int IDENTITY(1, 1) PRIMARY KEY,
	id_stranke int NOT NULL FOREIGN KEY REFERENCES Stranka(id_stranke),
	id_dostavljalca int FOREIGN KEY REFERENCES Dostavljalec(id_dostavljalca),
	cas_narocila datetime NOT NULL DEFAULT GETDATE(),
	status varchar(15) DEFAULT('sprejeto') CHECK(status IN ('sprejeto', 'v pripravi', 'na poti', 'dostavljeno'))
);

CREATE TABLE PostavkaNarocila(
	id_postavke int IDENTITY(1, 1) PRIMARY KEY,
	id_narocila int NOT NULL FOREIGN KEY REFERENCES Narocilo(id_narocila),
	id_jedi int NOT NULL FOREIGN KEY REFERENCES Jed(id_jedi),
	kolicina tinyint NOT NULL DEFAULT(1) CHECK(kolicina BETWEEN 1 AND 20),
	opomba nvarchar(100)
);