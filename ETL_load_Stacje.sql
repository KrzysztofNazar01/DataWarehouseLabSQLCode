USE Trains_3
GO 
If (object_id('vETLDimStacje') is not null) Drop View vETLDimStacje;
GO
CREATE VIEW vETLDimStacje
AS
SELECT DISTINCT
	[Id_stacji],
	[Miejscowosc], 
	[Nazwa],
	[Rok_remontu]
	FROM Trains_3_schema.dbo.Stacje
GO

--select * from  vETLDimStacje

MERGE INTO Stacje as S1
	USING vETLDimStacje as S2
		ON S1.Miejscowosc = S1.Miejscowosc
			AND  S1.Nazwa = S2.Nazwa
			WHEN Not Matched
			THEN
				INSERT
				VALUES (
					S2.Id_stacji,
					S2.Miejscowosc,
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
			;

-- INSERTING CHANGED ROWS TO THE DIMSELLER TABLE
INSERT INTO Stacje(
	Id_stacji_bd,
	Miejscowosc, 
	Nazwa, 
	Rok_remontu,
	Czy_aktualna
	)
	SELECT 
		Id_stacji,
		Miejscowosc, 
		Nazwa, 
		Rok_remontu,
		1
	FROM vETLDimStacje
	EXCEPT
	SELECT 
		Id_stacji_bd,
		Miejscowosc, 
		Nazwa, 
		Rok_remontu,
		1
	FROM Stacje;


Drop View vETLDimStacje;

/*
Use Trains_3
Select * from Stacje order by Id_stacji_bd
*/


