USE Trains_3
GO 
If (object_id('vETLDimTrasy') is not null) Drop View vETLDimTrasy;
go
CREATE VIEW vETLDimTrasy
AS
SELECT DISTINCT 
	S_pocz_DW.[Id_stacji] AS [Id_stacji_poczatkowej],
	S_kon_DW.[Id_stacji] AS [Id_stacji_koncowej]
	FROM Trains_3_schema.dbo.Trasy AS T
	JOIN Trains_3_schema.dbo.Stacje AS S_pocz ON T.[Id_stacji_poczatkowej] = S_pocz.[Id_stacji]
	JOIN Trains_3_schema.dbo.Stacje AS S_kon ON T.[Id_stacji_koncowej] = S_kon.[Id_stacji]
	JOIN [dbo].[Stacje] AS S_pocz_DW ON S_pocz_DW.[Id_stacji_bd] = S_pocz.[Id_stacji] AND S_pocz_DW.[Czy_aktualna] = 1
	JOIN [dbo].[Stacje] AS S_kon_DW ON S_kon_DW.[Id_stacji_bd] = S_kon.[Id_stacji] AND S_kon_DW.[Czy_aktualna] = 1;
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

			;

Drop View vETLDimTrasy;
/*
USE Trains_3_schema
SELECT * FROM Trasy order by Id_stacji_koncowej
Select * from Stacje order by Id_stacji

USE Trains_3
SELECT * FROM Trasy order by Id_stacji_koncowej
Select * from Stacje order by Id_stacji_bd

*/

