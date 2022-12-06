-- Import the data - it works
use Trains_3_schema
go

BULK INSERT dbo.Stacje
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\stations0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )

Select * from Stacje


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
	FROM Trains_3_schema.dbo.Stacje
go

--SET IDENTITY_INSERT Stacje ON
--SET IDENTITY_INSERT vETLDimStacje ON

MERGE INTO Stacje as S1
	USING vETLDimStacje as S2
		ON  S1.Miejscowość = S2.Miejscowość AND S1.Nazwa = S2.Nazwa
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
				


			WHEN Not Matched By Source
			Then
				DELETE
			;
USE Trains_3_schema
SELECT * FROM Stacje;
USE Trains_3
SELECT * FROM Stacje;

Drop View vETLDimStacje;

USE Trains_3
DELETE FROM Stacje