-- Import the data - it works
use Trains_3_schema
go

If (object_id('dbo.PrzejazdyDB') is not null) DROP TABLE dbo.PrzejazdyDB;
CREATE TABLE PrzejazdyDB(
    Id_przejazdu int identity(1,1) PRIMARY KEY,
    Data_planowany_wyjazd DateTime NOT NULL,
    Data_planowany_przyjazd DateTime NOT NULL,
	Data_rzeczywisty_wyjazd DateTime NOT NULL,
    Data_rzeczywisty_przyjazd DateTime NOT NULL,
	Id_pociągu int FOREIGN KEY REFERENCES Pociągi(Id_pociągu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
	Id_maszynisty varchar(11) FOREIGN KEY REFERENCES Maszyniści(PESEL) NOT NULL
);
go

BULK INSERT dbo.PrzejazdyDB
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\trainRuns0.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

--Select * from dbo.PrzejazdyDB



If (object_id('dbo.PrzejazdySheet') is not null) DROP TABLE dbo.PrzejazdySheet;
CREATE TABLE PrzejazdySheet(
    Id_przejazdu int FOREIGN KEY REFERENCES PrzejazdyDB(Id_przejazdu) NOT NULL,
	Masa_przewozonego_towaru int NOT NULL,
	Liczba_zajetych_miejsc int NOT NULL,
	Max_liczba_miejsc int NOT NULL,  
    Max_ladownosc int NOT NULL,
	Id_maszynisty varchar(11) FOREIGN KEY REFERENCES Maszyniści(PESEL) NOT NULL,
	Data_przejazdu DateTime NOT NULL,
	Opoznienie int NOT NULL,
	Czy_wystapila_awaria int NOT NULL

);
go

BULK INSERT dbo.PrzejazdySheet
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\trainRunsSheet0.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

--Select * from dbo.PrzejazdySheet



