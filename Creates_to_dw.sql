use Trains_3
CREATE TABLE Maszyniœci (
	Id_maszynisty int identity(1,1) PRIMARY KEY,
    Imiê_nazwisko varchar(50) NOT NULL,
    P³eæ varchar(9) CHECK(P³eæ='Kobieta' OR P³eæ='Mezczyzna') NOT NULL,
    PESEL varchar(11) CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL
);


CREATE TABLE Stacje(
    Id_stacji int identity(1,1) PRIMARY KEY,
	Miejscowoœæ varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
    Czy_aktualna BIT NOT NULL,
);
  
CREATE TABLE Trasy(
   Id_trasy int identity(1,1) PRIMARY KEY,
   Id_stacji_pocz¹tkowej int FOREIGN KEY REFERENCES Stacje(Id_stacji),
   Id_stacji_koñcowej int FOREIGN KEY REFERENCES Stacje(Id_stacji)
 );
  
CREATE TABLE Poci¹gi(
    Id_poci¹gu int identity(1,1) PRIMARY KEY,
    Typ varchar(10) NOT NULL,
    Typ_towaru varchar(20) NOT NULL,
);
  
  
CREATE TABLE Data(
    Id_daty int identity(1,1) PRIMARY KEY,
    Rok int check(Rok>=1990 AND Rok<=2022) not NULL,
    Miesi¹c varchar(15) CHECK(Miesi¹c IN('Styczeñ','Luty','Marzec','Kwiecieñ','Maj','Czerwiec','Lipiec','Sierpieñ','Wrzesieñ','PaŸdziernik','Listopad','Grudzieñ')) NOT NULL,
    Numer_miesi¹ca int CHECK(Numer_miesi¹ca>=1 AND Numer_miesi¹ca<=12) NOT NULL,
    Dzieñ int Check(Dzieñ>=1 AND Dzieñ<=31) not NULL,
    Dzieñ_tygodnia varchar(15) Check(Dzieñ_tygodnia IN('Poniedzia³ek','Wtorek','Œroda','Czwartek','Pi¹tek','Sobota','Niedziela')) Not NULL,
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
    Id_maszynisty int FOREIGN KEY REFERENCES Maszyniœci(Id_maszynisty) NOT NULL,
    Id_poci¹gu int FOREIGN KEY REFERENCES Poci¹gi(Id_poci¹gu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
    Id_daty_wyjazdu int FOREIGN KEY REFERENCES Data(Id_daty) NOT NULL,
    Id_planowanego_czasu_przyjazdu int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Id_rzeczywstego_czasu_przyjazdu int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    OpóŸnienie int,
	Czy_wyst¹pi³a_awaria BIT NOT NULL,
	Liczba_zajêtych_miejsc int NOT NULL, 
	Max_liczba_miejsc int NOT NULL,  
    Procent_zajêtych_miejsc int CHECK(Procent_zajêtych_miejsc>=0 AND Procent_zajêtych_miejsc<=100) NOT NULL,
	Masa_towaru int NOT NULL,
    Max_³adownoœæ int NOT NULL
);
  
CREATE TABLE Awarie(
    Id_awarii int identity(1,1) PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
    Id_daty_awarii int FOREIGN KEY REFERENCES data(Id_daty) NOT NULL,
    Id_czasu_awarii int FOREIGN KEY REFERENCES Czas(Id_czasu) NOT NULL,
    Czy_naprawiono_na_miejscu BIT NOT NULL,
    Czas_naprawy int not NULL
);




