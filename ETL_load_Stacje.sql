﻿/*
ladujemy dane do bazy danych
zaladowac dane dal t1 - pierwszy ETL (dla t1)
wyczyscic baze danych
zaladowac nowe dane (dla t2)  --> rok remontu rozny lub nowe stacje sie pojawiają
robimy etl dla t2


*/
-- Prepare DATABASE Tables for t_0 and t_1
CREATE TABLE Stacje_0(
    Id_stacji int PRIMARY KEY,
	Miejscowość varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
);

CREATE TABLE Stacje_1(
    Id_stacji int PRIMARY KEY,
	Miejscowość varchar(50) NOT NULL,
    Nazwa varchar(50) NOT NULL,
    Rok_remontu int CHECK(Rok_remontu>=1900 AND Rok_remontu<=2022) NOT NULL,
);
-- Import the data - it works


use Trains_3_schema
go

BULK INSERT dbo.Stacje_0
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\stations0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )
Select * from Stacje_0


BULK INSERT dbo.Stacje_1
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\stations1.csv'
    WITH
    (
	DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )
Select * from Stacje_1



----- TODO: implement more and update the code below

USE Trains_3
GO 
If (object_id('vETLDimStacje') is not null) Drop View vETLDimStacje;
go
CREATE VIEW vETLDimStacje
AS
SELECT DISTINCT
	[Miejscowość], 
	[Nazwa],
	[Rok_remontu]
	FROM Trains_3_schema.dbo.Stacje_0
go

--SET IDENTITY_INSERT Stacje ON
--SET IDENTITY_INSERT vETLDimStacje ON

MERGE INTO Stacje as S1
	USING vETLDimStacje as S2
	--porownuj tylko klucz biznesowy

		ON  S1.Id_stacji = S2.Id_stacji
			WHEN Not Matched
			THEN
				INSERT
				Values (
					S2.Miejscowość,
					S2.Nazwa,
					S2.Rok_remontu,
					1
				)
			WHEN Matched --when Miejscowosc and Nazwa match
				-- but Rok_remontu doesn't
				AND (S1.Rok_remontu <> S2.Rok_remontu)
			THEN
				UPDATE
				SET S1.Czy_aktualna = 0
				-- tutaj insert z tabeli wymairow
				-- from select except
				-- ten select ma byc z hurtowni, z 


			WHEN Not Matched By Source --dane sa w hurtowni, ale nie ma tego w bazie danych
			Then
				UPDATE
				SET S1.Czy_aktualna = 0
			;


USE Trains_3_schema
SELECT * FROM Stacje_0;
USE Trains_3
SELECT * FROM Stacje;


Drop View vETLDimStacje;




------

USE Trains_3
GO 
If (object_id('vETLDimStacje') is not null) Drop View vETLDimStacje;
go
CREATE VIEW vETLDimStacje
AS
SELECT DISTINCT
	[Miejscowość], 
	[Nazwa],
	[Rok_remontu]
	FROM Trains_3_schema.dbo.Stacje_1
go

--SET IDENTITY_INSERT Stacje ON
--SET IDENTITY_INSERT vETLDimStacje ON

MERGE INTO Stacje as S1
	USING vETLDimStacje as S2
	--porownuj tylko klucz biznesowy

		ON  S1.Id_stacji = S2.Id_stacji
			WHEN Not Matched
			THEN
				INSERT
				Values (
					S2.Miejscowość,
					S2.Nazwa,
					S2.Rok_remontu,
					1
				)
			WHEN Matched --when Miejscowosc and Nazwa match
				-- but Rok_remontu doesn't
				AND (S1.Rok_remontu <> S2.Rok_remontu)
			THEN
				UPDATE
				SET S1.Czy_aktualna = 0
				-- tutaj insert z tabeli wymairow
				-- from select except
				-- ten select ma byc z hurtowni, z 


			WHEN Not Matched By Source --dane sa w hurtowni, ale nie ma tego w bazie danych
			Then
				UPDATE
				SET S1.Czy_aktualna = 0
			;




-- INSERTING CHANGED ROWS TO THE DIMSELLER TABLE
INSERT INTO Stacje(
	--Id_stacji,
	Miejscowość, 
	Nazwa, 
	Rok_remontu
	)
	SELECT 
		--Id_stacji,
		Miejscowość, 
		Nazwa, 
		Rok_remontu,
		1
	FROM vETLDimSellersData
	EXCEPT
	SELECT 
		--Id_stacji.
		Miejscowość, 
		Nazwa, 
		Rok_remontu,
		1
	FROM Stacje;





USE Trains_3_schema
SELECT * FROM Stacje_1;
USE Trains_3
SELECT * FROM Stacje;


Drop View vETLDimStacje;



