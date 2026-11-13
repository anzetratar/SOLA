USE master;

DROP DATABASE Avtosola;
CREATE DATABASE Avtosola;

USE Avtosola;
GO

CREATE TABLE Instruktor(
    id_instruktorja int IDENTITY(1, 1) PRIMARY KEY,
    ime_priimek nvarchar(80) NOT NULL,
    telefon varchar(15) UNIQUE,
    datum_zaposlitve date DEFAULT GETDATE(),
    urna_postavka money CHECK(urna_postavka >= 10.00)
);

CREATE TABLE Vozilo(
    id_vozila int IDENTITY(1, 1) PRIMARY KEY,
    registracija varchar(10) NOT NULL UNIQUE,
    znamka nvarchar(30) NOT NULL,
    menjalnik varchar(12) DEFAULT('rocni') CHECK(menjalnik IN ('rocni', 'avtomatski')),
    letnik smallint CHECK(letnik >= 2010)
);

CREATE TABLE Kandidat(
    id_kandidata int IDENTITY(1, 1) PRIMARY KEY,
    ime_priimek nvarchar(80) NOT NULL,
    emso char(13) NOT NULL UNIQUE CHECK(LEN(emso) = 13),
    datum_vpisa date DEFAULT GETDATE(),
    id_instruktorja int NOT NULL FOREIGN KEY REFERENCES Instruktor(id_instruktorja)
);

CREATE TABLE UraVoznje(
    id_ure int IDENTITY(1, 1) PRIMARY KEY,
    id_kandidata int NOT NULL FOREIGN KEY REFERENCES Kandidat(id_kandidata),
    id_vozila int NOT NULL FOREIGN KEY REFERENCES Vozilo(id_vozila),
    zacetek datetime NOT NULL DEFAULT GETDATE(),
    trajanje_min tinyint DEFAULT(45) CHECK(trajanje_min IN (45, 90))
);

CREATE TABLE Izpit(
    id_izpita int IDENTITY(1, 1) PRIMARY KEY,
    id_kandidata int NOT NULL FOREIGN KEY REFERENCES Kandidat(id_kandidata),
    datum_izpita date NOT NULL,
    vrsta varchar(10) NOT NULL CHECK(vrsta IN ('teorija', 'voznja')),
    opravljen bit DEFAULT(0)
);