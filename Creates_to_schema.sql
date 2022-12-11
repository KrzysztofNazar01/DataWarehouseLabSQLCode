--Create database Trains_3_schema
use Trains_3_schema

CREATE TABLE Maszyniœci (
	PESEL int CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') PRIMARY KEY,
    -- In DW you should concatanate Imie and Nazwisko to one variable called "Imie_naziwsko"
	Imie varchar(50) NOT NULL,
	Nazwisko varchar(50) NOT NULL,
    P³eæ varchar(20) CHECK(P³eæ='Kobieta' OR P³eæ='Mezczyzna') NOT NULL,
    
);


CREATE TABLE Stacje(
    Id_stacji int PRIMARY KEY,
	Miejscowoœæ varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
);
  
CREATE TABLE Trasy(
   Id_trasy int PRIMARY KEY,
   Id_stacji_pocz¹tkowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Id_stacji_koñcowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Odleg³oœæ int 
 );
  
CREATE TABLE Poci¹gi(
    Id_poci¹gu int PRIMARY KEY,
    Typ varchar(10) CHECK(Typ IN ('Intercity','Regio','Arriva','EIP','SKM')) NOT NULL,
    Typ_towaru varchar(20) CHECK(Typ_towaru In('Elektronika','Wegiel','Paliwo','Poczta')) NOT NULL,
);
  
--drop table Awarie
--drop table Przejazdy

CREATE TABLE Przejazdy(
    Id_przejazdu int PRIMARY KEY,
    PESEL varchar(11) FOREIGN KEY REFERENCES Maszyniœci(PESEL) NOT NULL,
    Id_poci¹gu int FOREIGN KEY REFERENCES Poci¹gi(Id_poci¹gu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
    Planowanego_czasu_przyjazdu DateTime NOT NULL,
    Rzeczywstego_czasu_przyjazdu DateTime  NOT NULL, 
    Max_liczba_miejsc int NOT NULL,  
    Max_³adownoœæ int NOT NULL
);
  
CREATE TABLE Awarie(
    Id_awarii int PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
	Data_awarii DateTime NOT NULL
);




