USE Trains_3
GO 
If (object_id('vETLDimPociagi') is not null) Drop View vETLDimPociagi;
go
CREATE VIEW vETLDimPociagi
AS
SELECT DISTINCT
	[Id_pociągu],
	[Typ], 
	[Typ_towaru]
	FROM Trains_3_schema.dbo.Pociągi
go

--select * from vETLDimPociagi

MERGE INTO Pociągi as DW
	USING vETLDimPociagi as DB
		ON  DW.Typ = DB.Typ AND DW.Typ_towaru = DB.Typ_towaru
			WHEN Not Matched
			THEN
				INSERT
				Values (
					Typ,
					Typ_towaru
				)

			;

Drop View vETLDimPociagi;

