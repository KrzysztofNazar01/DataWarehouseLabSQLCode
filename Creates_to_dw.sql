use Trains_3
CREATE TABLE Maszyni�ci (
	Id_maszynisty int identity(1,1) PRIMARY KEY,
    Imi�_nazwisko varchar(50) NOT NULL,
    P�e� varchar(9) CHECK(P�e�='Kobieta' OR P�e�='Mezczyzna') NOT NULL,
    PESEL varchar(11) CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL
);


CREATE TABLE Stacje(
    Id_stacji int identity(1,1) PRIMARY KEY,
	Miejscowo�� varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
    Czy_aktualna BIT NOT NULL,
);
  
CREATE TABLE Trasy(
   Id_trasy int identity(1,1) PRIMARY KEY,
   Id_stacji_pocz�tkowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Id_stacji_ko�cowej int FOREIGN KEY REFERENCES Stacje(Id_stacji)
 );
  
CREATE TABLE Poci�gi(
    Id_poci�gu int identity(1,1) PRIMARY KEY,
    Typ varchar(10) NOT NULL,
    Typ_towaru varchar(20) NOT NULL,
);
  
  
CREATE TABLE Data(
    Id_daty int identity(1,1) PRIMARY KEY,
    Rok int check(Rok>=1990 AND Rok<=2022) not NULL,
    Miesi�c varchar(15) CHECK(Miesi�c IN('Stycze�','Luty','Marzec','Kwiecie�','Maj','Czerwiec','Lipiec','Sierpie�','Wrzesie�','Pa�dziernik','Listopad','Grudzie�')) NOT NULL,
    Numer_miesi�ca int CHECK(Numer_miesi�ca>=1 AND Numer_miesi�ca<=12) NOT NULL,
    Dzie� int Check(Dzie�>=1 AND Dzie�<=31) not NULL,
    Dzie�_tygodnia varchar(15) Check(Dzie�_tygodnia IN('Poniedzia�ek','Wtorek','�roda','Czwartek','Pi�tek','Sobota','Niedziela')) Not NULL,
    Numer_dnia_tygodnia int Check(Numer_dnia_tygodnia>=1 aND Numer_dnia_tygodnia<=7) NOT NULL
);
 
/*
use Trains_3
select * from Czas
*/

CREATE TABLE Czas(
    Id_czasu int identity(1,1) PRIMARY KEY,
    Godzina int CHECK(Godzina>=0 AND Godzina<=23) not NULL,
    Minuta int CHECK(Minuta>=0 AND Minuta<=59) not NULL,
  );
CREATE TABLE Przejazdy(
    Id_przejazdu int identity(1,1) PRIMARY KEY,
    Id_maszynisty int FOREIGN KEY REFERENCES Maszyni�ci(Id_maszynisty) NOT NULL,
    Id_poci�gu int FOREIGN KEY REFERENCES Poci�gi(Id_poci�gu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
    Id_daty_wyjazdu int FOREIGN KEY REFERENCES Data(Id_daty) NOT NULL,
    Id_planowanego_czasu_przyjazdu int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Id_rzeczywstego_czasu_przyjazdu int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Op�nienie int,
	Czy_wyst�pi�a_awaria BIT NOT NULL,
	Liczba_zaj�tych_miejsc int NOT NULL, 
	Max_liczba_miejsc int NOT NULL,  
    Procent_zaj�tych_miejsc int CHECK(Procent_zaj�tych_miejsc>=0 AND Procent_zaj�tych_miejsc<=100) NOT NULL,
	Masa_towaru int NOT NULL,
    Max_�adowno�� int NOT NULL
);
  
CREATE TABLE Awarie(
    Id_awarii int identity(1,1) PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
    Id_daty_awarii int FOREIGN KEY REFERENCES data(Id_daty) NOT NULL,
    Id_czasu_awarii int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Czy_naprawiono_na_miejscu BIT NOT NULL,
    Czas_naprawy int not NULL
);




