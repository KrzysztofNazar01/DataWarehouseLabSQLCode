use Trains_3

use Trains_3
CREATE TABLE Czas(
    Id_czasu int identity(1,1) PRIMARY KEY,
    Godzina int CHECK(Godzina>=0 AND Godzina<=23) not NULL,
    Minuta int CHECK(Minuta>=0 AND Minuta<=59) not NULL,
  );


/*use Trains_3 SELECT * FROM Awarie
*/
use Trains_3
CREATE TABLE Data(
    Id_daty int identity(1,1) PRIMARY KEY,
	Data datetime,
    Rok int check(Rok>=1990 AND Rok<=2022) not NULL,
    Miesiac varchar(15) NOT NULL,
    Numer_miesiaca int CHECK(Numer_miesiaca>=1 AND Numer_miesiaca<=12) NOT NULL,
    Dzien int Check(Dzien>=1 AND Dzien<=31) not NULL,
    Dzien_tygodnia varchar(15) Not NULL,
    Numer_dnia_tygodnia int Check(Numer_dnia_tygodnia>=1 AND Numer_dnia_tygodnia<=7) NOT NULL
);
GO
-- SELECT * FROM Data


-- do the ETL for Czas and Data
-- then do next creates:

use Trains_3
CREATE TABLE Maszynisci (
	Id_maszynisty bigint identity(1,1) PRIMARY KEY,
    Imie_nazwisko varchar(50) NOT NULL,
    Plec varchar(50) NOT NULL,
    PESEL bigint NOT NULL
);

use Trains_3
CREATE TABLE Stacje(
	-- "Id_stacji" to numer rekordu w Hurtowni Danych (DW)
    Id_stacji int identity(1,1) PRIMARY KEY,

	-- "Id_stacji_bd" to Id_stacji z Bazy Danych (DB)
	-- dodatkowe pole bo scd2 nie bedzie dzialac inaczej
	-- dzieki niemu mozna zapamietac polaczenia, bo inaczej Id_Stacji sie zmienialo i za bardzo roslo 
	Id_stacji_bd int NOT NULL,

	Miejscowosc varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
    Czy_aktualna BIT NOT NULL,
);
 
use Trains_3
CREATE TABLE Trasy(
   Id_trasy int identity(1,1) PRIMARY KEY,
   Id_stacji_poczatkowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Id_stacji_koncowej int FOREIGN KEY REFERENCES Stacje(Id_stacji)
 );

use Trains_3
CREATE TABLE Pociagi(
    Id_pociagu int identity(1,1) PRIMARY KEY,
    Typ varchar(10) NOT NULL,
    Typ_towaru varchar(20) NOT NULL,
	Ladownosc int NOT NULL,
	Miejsca int NOT NULL,
);
 

use Trains_3
CREATE TABLE Przejazdy(
    Id_przejazdu int identity(1,1) PRIMARY KEY,
    Id_maszynisty bigint FOREIGN KEY REFERENCES Maszynisci(Id_maszynisty) NOT NULL,
    Id_pociagu int FOREIGN KEY REFERENCES Pociagi(Id_pociagu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
    Id_daty_wyjazdu int FOREIGN KEY REFERENCES Data(Id_daty) NOT NULL,
    Id_planowanego_czasu_przyjazdu int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Id_rzeczywstego_czasu_przyjazdu int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Opoznienie int,
	Czy_wystapila_awaria BIT NOT NULL,
	Liczba_zajetych_miejsc int NOT NULL, 
	Max_liczba_miejsc int NOT NULL,  
    Procent_zajetych_miejsc int CHECK(Procent_zajetych_miejsc>=0 AND Procent_zajetych_miejsc<=100) NOT NULL,
	Masa_towaru int NOT NULL,
    Max_ladownosc int NOT NULL
);


use Trains_3
CREATE TABLE Awarie(
    Id_awarii int identity(1,1) PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
    Id_daty_awarii int FOREIGN KEY REFERENCES data(Id_daty) NOT NULL,
    Id_czasu_awarii int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Czy_naprawiono_na_miejscu BIT NOT NULL,
    Czas_naprawy int not NULL
);




