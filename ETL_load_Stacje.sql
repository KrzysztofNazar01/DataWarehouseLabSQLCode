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

MERGE INTO Stacje as S1
	USING vETLDimStacje as S2
	--porownuj tylko klucz biznesowy

		ON  S1.Miejscowość = S1.Miejscowość AND  S1.Nazwa = S2.Nazwa
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

Drop View vETLDimStacje;

/*
USE Trains_3_schema
SELECT * FROM Stacje_0;
SELECT * FROM Stacje_1;

USE Trains_3
SELECT * FROM Stacje;

USE Trains_3
delete Stacje;

*/






-- INSERTING CHANGED ROWS TO THE DIMSELLER TABLE
INSERT INTO Stacje(
	--Id_stacji,
	Miejscowość, 
	Nazwa, 
	Rok_remontu,
	Czy_aktualna
	)
	SELECT 
		--Id_stacji,
		Miejscowość, 
		Nazwa, 
		Rok_remontu,
		1
	FROM vETLDimStacje
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



