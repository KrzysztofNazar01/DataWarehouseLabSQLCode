/*


use Trains_3_schema
drop Maszyni�ci
*/

use Trains_3_schema
go

BULK INSERT dbo.Maszyni�ci
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\drivers0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
	--FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )

Select * from Maszyni�ci



USE Trains_3
GO 
If (object_id('vETLDimMaszynisci') is not null) Drop View vETLDimMaszynisci;
go
CREATE VIEW vETLDimMaszynisci
AS
SELECT DISTINCT
	[PESEL], 
	[Imie],
	[Nazwisko],
	[P�e�]
	FROM Trains_3_schema.dbo.Maszyni�ci
go


-- drop wszedzie icreate wszedzie

select * from vETLDimMaszynisci
--SET IDENTITY_INSERT Stacje ON
--SET IDENTITY_INSERT vETLDimStacje ON

MERGE INTO Maszyni�ci as DW
	USING vETLDimMaszynisci as DB
		ON  DW.PESEL = DB.PESEL
			WHEN Not Matched
			THEN
				INSERT
				Values (
					--CONCAT(DB.Imie, ' ' , DB.Nazwisko), -- stara wersja
					Cast(DB.[Imie] + ' ' + DB.[Nazwisko] as nvarchar(128)), -- nowa wersja
					DB.[P�e�],
					DB.[PESEL]
				)
			
			WHEN Not Matched By Source
			Then
				DELETE
			;
USE Trains_3_schema
SELECT * FROM Stacje;
USE Trains_3
SELECT * FROM Stacje;

Drop View vETLDimMaszynisci;

USE Trains_3
DELETE FROM Stacje
