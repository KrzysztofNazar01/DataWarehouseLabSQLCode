USE Trains_3
GO 
If (object_id('vETLDimTrasy') is not null) Drop View vETLDimTrasy;
go
CREATE VIEW vETLDimTrasy
AS
SELECT DISTINCT 
	[Id_stacji_poczatkowej],
	[Id_stacji_koncowej]
	FROM Trains_3_schema.dbo.Trasy
go


--select * from Trains_3_schema.dbo.Trasy

MERGE INTO Trasy as DW
	USING vETLDimTrasy as DB
		ON  DW.Id_stacji_poczatkowej = DB.Id_stacji_poczatkowej
		AND DW.Id_stacji_koncowej = DB.Id_stacji_koncowej
			WHEN Not Matched
			THEN
				INSERT
				Values (
					DB.Id_stacji_poczatkowej
					, DB.Id_stacji_koncowej
				)
			
			WHEN Not Matched By Source
			Then
				DELETE
			;

Drop View vETLDimTrasy;
/*
USE Trains_3_schema
SELECT * FROM Trasy order by Id_stacji_koncowej
Select * from Stacje order by Id_stacji

USE Trains_3
SELECT * FROM Trasy order by Id_stacji_koncowej
Select * from Stacje order by Id_stacji_bd
Drop View vETLDimTrasy;

*/

