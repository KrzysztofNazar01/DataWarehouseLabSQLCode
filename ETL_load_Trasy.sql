-- Import the data - it works
use Trains_3_schema
go

BULK INSERT dbo.Trasy
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\routes0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )

Select * from Trasy


USE Trains_3
GO 
If (object_id('vETLDimTrasy') is not null) Drop View vETLDimTrasy;
go
CREATE VIEW vETLDimTrasy
AS
SELECT DISTINCT 
	[Id_stacji_początkowej],
	[Id_stacji_końcowej]
	FROM Trains_3_schema.dbo.Trasy
go




select * from vETLDimTrasy
--SET IDENTITY_INSERT Stacje ON
--SET IDENTITY_INSERT vETLDimStacje ON

MERGE INTO Trasy as DW
	USING vETLDimTrasy as DB
		ON  DW.Id_stacji_początkowej = DB.Id_stacji_początkowej
		AND DW.Id_stacji_końcowej = DB.Id_stacji_końcowej
			WHEN Not Matched
			THEN
				INSERT
				Values (
					Id_stacji_początkowej
					, Id_stacji_końcowej
				)
			
			WHEN Not Matched By Source
			Then
				DELETE
			;
USE Trains_3_schema
SELECT * FROM Trasy;
Select * from Stacje

USE Trains_3
SELECT * FROM Trasy;
Select * from Stacje
Drop View vETLDimTrasy;

