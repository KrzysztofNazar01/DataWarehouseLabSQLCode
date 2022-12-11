--Create database Trains_3_schema
use Trains_3_schema

CREATE TABLE Maszyni�ci (
	PESEL int CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') PRIMARY KEY,
    -- In DW you should concatanate Imie and Nazwisko to one variable called "Imie_naziwsko"
	Imie varchar(50) NOT NULL,
	Nazwisko varchar(50) NOT NULL,
    P�e� varchar(20) CHECK(P�e�='Kobieta' OR P�e�='Mezczyzna') NOT NULL,
    
);


CREATE TABLE Stacje(
    Id_stacji int PRIMARY KEY,
	Miejscowo�� varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
);
  
CREATE TABLE Trasy(
   Id_trasy int PRIMARY KEY,
   Id_stacji_pocz�tkowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Id_stacji_ko�cowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Odleg�o�� int 
 );
  
CREATE TABLE Poci�gi(
    Id_poci�gu int PRIMARY KEY,
    Typ varchar(10) CHECK(Typ IN ('Intercity','Regio','Arriva','EIP','SKM')) NOT NULL,
    Typ_towaru varchar(20) CHECK(Typ_towaru In('Elektronika','Wegiel','Paliwo','Poczta')) NOT NULL,
);
  
--drop table Awarie
--drop table Przejazdy

CREATE TABLE Przejazdy(
    Id_przejazdu int PRIMARY KEY,
    PESEL varchar(11) FOREIGN KEY REFERENCES Maszyni�ci(PESEL) NOT NULL,
    Id_poci�gu int FOREIGN KEY REFERENCES Poci�gi(Id_poci�gu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
    Planowanego_czasu_przyjazdu DateTime NOT NULL,
    Rzeczywstego_czasu_przyjazdu DateTime  NOT NULL, 
    Max_liczba_miejsc int NOT NULL,  
    Max_�adowno�� int NOT NULL
);
  
CREATE TABLE Awarie(
    Id_awarii int PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
	Data_awarii DateTime NOT NULL
);




