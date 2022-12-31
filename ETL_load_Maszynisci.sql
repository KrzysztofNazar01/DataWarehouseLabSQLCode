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
	[Plec]
	FROM Trains_3_schema.dbo.Maszynisci
go

MERGE INTO Maszynisci as DW
	USING vETLDimMaszynisci as DB
		ON  DW.PESEL = DB.PESEL
			WHEN Not Matched
			THEN
				INSERT
				Values (
					--CONCAT(DB.Imie, ' ' , DB.Nazwisko), -- stara wersja
					Cast(DB.[Imie] + ' ' + DB.[Nazwisko] as nvarchar(50)), -- nowa wersja
					DB.[Plec],
					DB.[PESEL]
				)
			;

Drop View vETLDimMaszynisci;

/*
USE Trains_3
select * from Maszynisci
*/