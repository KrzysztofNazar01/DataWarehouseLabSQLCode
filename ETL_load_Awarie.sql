-- Import the data - it works
use Trains_3_schema
go

If (object_id('dbo.AwarieDB') is not null) DROP TABLE dbo.AwarieDB;
CREATE TABLE AwarieDB(
    Id_awarii int PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
	Data_awarii DateTime NOT NULL
);
go

BULK INSERT dbo.AwarieDB
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\malfunction0.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

--Select * from dbo.AwarieDB



If (object_id('dbo.AwarieSheet') is not null) DROP TABLE dbo.AwarieSheet;
CREATE TABLE AwarieSheet(
    Id_awarii int PRIMARY KEY,
    Id_przejazdu int FOREIGN KEY REFERENCES Przejazdy(Id_przejazdu) NOT NULL,
	Data_awarii DateTime NOT NULL,
	Czy_naprawiono_na_miejscu BIT NOT NULL,
    Czas_naprawy int not NULL
);
go

BULK INSERT dbo.AwarieSheet
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\malfunction_sheet0.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

--Select * from dbo.AwarieSheet



