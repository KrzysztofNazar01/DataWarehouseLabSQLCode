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


--select * from vETLDimTrasy

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


/*
USE Trains_3_schema
SELECT * FROM Trasy;
Select * from Stacje

USE Trains_3
SELECT * FROM Trasy;
Select * from Stacje
Drop View vETLDimTrasy;

*/

