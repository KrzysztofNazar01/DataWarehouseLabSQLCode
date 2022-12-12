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
	[P³eæ]
	FROM Trains_3_schema.dbo.Maszyniœci
go

MERGE INTO Maszyniœci as DW
	USING vETLDimMaszynisci as DB
		ON  DW.PESEL = DB.PESEL
			WHEN Not Matched
			THEN
				INSERT
				Values (
					--CONCAT(DB.Imie, ' ' , DB.Nazwisko), -- stara wersja
					Cast(DB.[Imie] + ' ' + DB.[Nazwisko] as nvarchar(128)), -- nowa wersja
					DB.[P³eæ],
					DB.[PESEL]
				)
			
			WHEN Not Matched By Source
			Then
				DELETE
			;

Drop View vETLDimMaszynisci;

