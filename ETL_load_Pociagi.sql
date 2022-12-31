USE Trains_3
GO 
If (object_id('vETLDimPociagi') is not null) Drop View vETLDimPociagi;
go
CREATE VIEW vETLDimPociagi
AS
SELECT DISTINCT
	[Id_pociagu],
	[Typ], 
	[Typ_towaru],
	[Ladownosc],
	[Miejsca]
	FROM Trains_3_schema.dbo.Pociagi
go

--   select * from Trains_3_schema.dbo.Pociagi

MERGE INTO Pociagi as DW
	USING vETLDimPociagi as DB
		ON  DW.Typ = DB.Typ
		AND DW.Typ_towaru = DB.Typ_towaru
			WHEN Not Matched
			THEN
				INSERT
				Values (
					DB.Typ,
					DB.Typ_towaru,
					DB.Ladownosc,
					DB.Miejsca
				)

			;

Drop View vETLDimPociagi;


/*


USE Trains_3_schema
select * from Pociagi

USE Trains_3
select * from Pociagi

*/