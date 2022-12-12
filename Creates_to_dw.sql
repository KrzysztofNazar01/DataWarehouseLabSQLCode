use Trains_3

CREATE TABLE Czas(
    Id_czasu int identity(1,1) PRIMARY KEY,
    Godzina int CHECK(Godzina>=0 AND Godzina<=23) not NULL,
    Minuta int CHECK(Minuta>=0 AND Minuta<=59) not NULL,
  );

CREATE TABLE DimDate
(
    DateKey INTEGER IDENTITY(1,1) PRIMARY KEY,
    Date datetime unique,
	Year varchar(4),
	Month varchar(10),
	MonthNo int,
	DayOfWeek varchar(15),
	DayOfWeekNo int
)
GO

-- do the ETL for Czas and Data
-- then do next creates:

CREATE TABLE Maszynisci (
	Id_maszynisty int identity(1,1) PRIMARY KEY,
    Imie_nazwisko varchar(50) NOT NULL,
    Plec varchar(9) CHECK(Plec='Kobieta' OR Plec='Mezczyzna') NOT NULL,
    PESEL varchar(11) CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL
);


CREATE TABLE Stacje(
    Id_stacji int identity(1,1) PRIMARY KEY,
	Miejscowosc varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
    Czy_aktualna BIT NOT NULL,
);
  
CREATE TABLE Trasy(
   Id_trasy int identity(1,1) PRIMARY KEY,
   Id_stacji_poczatkowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Id_stacji_koñcowej int FOREIGN KEY REFERENCES Stacje(Id_stacji)
 );
  
CREATE TABLE Pociagi(
    Id_pociagu int identity(1,1) PRIMARY KEY,
    Typ varchar(10) NOT NULL,
    Typ_towaru varchar(20) NOT NULL,
);
  
  
CREATE TABLE Data(
    Id_daty int identity(1,1) PRIMARY KEY,
    Rok int check(Rok>=1990 AND Rok<=2022) not NULL,
    Miesiac varchar(15) CHECK(Miesiac IN('Styczen','Luty','Marzec','Kwiecien','Maj','Czerwiec','Lipiec','Sierpien','Wrzesien','PaŸdziernik','Listopad','Grudzien')) NOT NULL,
    Numer_miesiaca int CHECK(Numer_miesiaca>=1 AND Numer_miesiaca<=12) NOT NULL,
    Dzien int Check(Dzien>=1 AND Dzien<=31) not NULL,
    Dzien_tygodnia varchar(15) Check(Dzien_tygodnia IN('Poniedzialek','Wtorek','Sroda','Czwartek','Piatek','Sobota','Niedziela')) Not NULL,
    Numer_dnia_tygodnia int Check(Numer_dnia_tygodnia>=1 aND Numer_dnia_tygodnia<=7) NOT NULL
);


CREATE TABLE Przejazdy(
    Id_przejazdu int identity(1,1) PRIMARY KEY,
    Id_maszynisty int FOREIGN KEY REFERENCES Maszynisci(Id_maszynisty) NOT NULL,
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
  
CREATE TABLE Awarie(
    Id_awarii int identity(1,1) PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
    Id_daty_awarii int FOREIGN KEY REFERENCES data(Id_daty) NOT NULL,
    Id_czasu_awarii int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Czy_naprawiono_na_miejscu BIT NOT NULL,
    Czas_naprawy int not NULL
);




