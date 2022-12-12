--Create database Trains_3_schema
use Trains_3_schema

If (object_id('dbo.Maszynisci') is not null) DROP TABLE dbo.Maszynisci;
CREATE TABLE Maszynisci(
	PESEL int CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') PRIMARY KEY,
    -- In DW you should concatanate Imie and Nazwisko to one variable called "Imie_naziwsko"
	Imie varchar(50) NOT NULL,
	Nazwisko varchar(50) NOT NULL,
    Plec varchar(20) CHECK(Plec='Kobieta' OR Plec='Mezczyzna') NOT NULL,
    
);

If (object_id('dbo.Stacje') is not null) DROP TABLE dbo.Stacje;
CREATE TABLE Stacje(
    Id_stacji int PRIMARY KEY,
	Miejscowosc varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
);
 
If (object_id('dbo.Trasy') is not null) DROP TABLE dbo.Trasy;
CREATE TABLE Trasy(
   Id_trasy int PRIMARY KEY,
   Id_stacji_poczatkowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Id_stacji_koncowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Odleglosc int 
 );

If (object_id('dbo.Pociagi') is not null) DROP TABLE dbo.Pociagi;
CREATE TABLE Pociagi(
    Id_poci퉓u int PRIMARY KEY,
    Typ varchar(10) CHECK(Typ IN ('Intercity','Regio','Arriva','EIP','SKM')) NOT NULL,
    Typ_towaru varchar(20) CHECK(Typ_towaru In('Elektronika','Wegiel','Paliwo','Poczta')) NOT NULL,
);


-- to chyba mozna usunac
If (object_id('dbo.Przejazdy') is not null) DROP TABLE dbo.Przejazdy;
CREATE TABLE Przejazdy(
    Id_przejazdu int PRIMARY KEY,
    PESEL varchar(11) FOREIGN KEY REFERENCES Maszyni쐁i(PESEL) NOT NULL,
    Id_pociagu int FOREIGN KEY REFERENCES Pociagi(Id_pociagu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
    Planowanego_czasu_przyjazdu DateTime NOT NULL,
    Rzeczywstego_czasu_przyjazdu DateTime  NOT NULL, 
    Max_liczba_miejsc int NOT NULL,  
    Max_ladownosc int NOT NULL
);


If (object_id('dbo.PrzejazdyDB') is not null) DROP TABLE dbo.PrzejazdyDB;
CREATE TABLE PrzejazdyDB(
    Id_przejazdu int PRIMARY KEY,
    Data_planowany_wyjazd DateTime NOT NULL,
    Data_planowany_przyjazd DateTime NOT NULL,
	Data_rzeczywisty_wyjazd DateTime NOT NULL,
    Data_rzeczywisty_przyjazd DateTime NOT NULL,
	Id_poci퉓u int FOREIGN KEY REFERENCES Poci퉓i(Id_poci퉓u) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
	Id_maszynisty int FOREIGN KEY REFERENCES Maszyni쐁i(PESEL) NOT NULL
);
go


If (object_id('dbo.PrzejazdySheet') is not null) DROP TABLE dbo.PrzejazdySheet;
CREATE TABLE PrzejazdySheet(
    Id_przejazdu int PRIMARY KEY,
	Masa_przewozonego_towaru int NOT NULL,
	Liczba_zajetych_miejsc int NOT NULL,
	Max_liczba_miejsc int NOT NULL,  
    Max_ladownosc int NOT NULL,
	Id_maszynisty int FOREIGN KEY REFERENCES Maszyni쐁i(PESEL) NOT NULL,
	Data_przejazdu DateTime NOT NULL,
	Opoznienie int NOT NULL,
	Czy_wystapila_awaria int NOT NULL

);


 -- tabele Awarie mozna usunac chyba
CREATE TABLE Awarie(
    Id_awarii int PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
	Data_awarii DateTime NOT NULL
);

If (object_id('dbo.AwarieDB') is not null) DROP TABLE dbo.AwarieDB;
CREATE TABLE AwarieDB(
    Id_awarii int PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
	Data_awarii DateTime NOT NULL
);

If (object_id('dbo.AwarieSheet') is not null) DROP TABLE dbo.AwarieSheet;
CREATE TABLE AwarieSheet(
    Id_awarii int PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
	Data_awarii DateTime NOT NULL,
	Czy_naprawiono_na_miejscu BIT NOT NULL,
    Czas_naprawy int not NULL
);
go


