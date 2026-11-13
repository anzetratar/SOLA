USE master;

DROP DATABASE VeterinarskaAmbulanta;
CREATE DATABASE VeterinarskaAmbulanta;

USE VeterinarskaAmbulanta;
GO

DROP TABLE Lastnik, Zival, Veterinar, Pregled, Racun;

CREATE TABLE Lastnik(
	id_lastnika int IDENTITY(1, 1) PRIMARY KEY,
	ime_priimek nvarchar(80) NOT NULL,
	telefon varchar(15) NOT NULL UNIQUE,
	email varchar(100) UNIQUE,
	datum_vpisa date DEFAULT GETDATE()
);

CREATE TABLE Zival(
	id_zivali int IDENTITY(1, 1) PRIMARY KEY,
	ime nvarchar(30) NOT NULL,
	vrsta varchar(30) NOT NULL DEFAULT('pes'),
	teza_kg decimal(5, 2) CHECK(teza_kg > 0),
	id_lastnika int NOT NULL FOREIGN KEY REFERENCES Lastnik(id_lastnika)
);

CREATE TABLE Veterinar(
	id_veterinarja int IDENTITY(1, 1) PRIMARY KEY,
	ime_priimek varchar(80) NOT NULL,
	st_licence char(8) UNIQUE NOT NULL,
	leta_izkusenj smallint DEFAULT(0) CHECK(leta_izkusenj BETWEEN 0 AND 50),
	aktiven bit DEFAULT(1)
);

CREATE TABLE Pregled(
	id_pregleda int IDENTITY(1, 1) PRIMARY KEY,
	id_zivalic int FOREIGN KEY REFERENCES Zival(id_zivali),
	id_veterinarja int FOREIGN KEY REFERENCES Veterinar(id_veterinarja),
	cas_pregleda datetime DEFAULT GETDATE(),
	diagnoza nvarchar(255)
);

create table Racun (
    id_racuna int identity(1,1) primary key,
    st_racuna char(10) not null unique,
    znesek money not null check (znesek > 0),
	nacin_placila varchar(10) DEFAULT('gotovina'), CHECK(nacin_placila IN ('gotovina', 'kartica', 'nakazilo')),
	id_pregleda int FOREIGN KEY REFERENCES Pregled(id_pregleda)
);