USE Trains_3
GO 
If (object_id('vETLDimAwarie') is not null) Drop View vETLDimAwarie;
go
CREATE VIEW vETLDimAwarie
AS
SELECT DISTINCT
	table1.[Id_awarii], 
	table1.[Id_przejazdu],
	SD.[DateKey],
	G.[Id_czasu] as Id_czasu,
	table2.[Czy_naprawiono_na_miejscu],
	table2.[Czas_naprawy]
	FROM Trains_3_schema.dbo.AwarieDB as table1
	JOIN Trains_3_schema.dbo.AwarieSheet as table2 ON table1.Id_awarii = table2.Id_awarii
	JOIN dbo.Czas as G ON G.Godzina = DATEPART(HOUR, table1.Data_awarii)
	JOIN dbo.Czas as M ON M.Minuta = DATEPART(MINUTE, table1.Data_awarii)
	JOIN dbo.DimDate as SD ON CONVERT(VARCHAR(10), SD.Date, 111) = CONVERT(VARCHAR(10), table1.[Data_awarii], 111)
Where
	G.[Id_czasu] = M.[Id_czasu]

go

MERGE INTO Awarie as DW
	USING vETLDimAwarie as DB

	--TODO
		ON  DW.Id_przejazdu = DB.Id_przejazdu
			AND DW.Id_daty_awarii = DB.DateKey
			AND DW.Id_czasu_awarii = DB.Id_czasu
			AND DW.Czy_naprawiono_na_miejscu = DB.Czy_naprawiono_na_miejscu
			AND DW.Czas_naprawy = DB.Czas_naprawy
			WHEN Not Matched
			THEN
				INSERT
				Values (
					DB.Id_przejazdu
					, DB.DateKey
					, DB.Id_czasu
					, DB.Czy_naprawiono_na_miejscu
					, DB.Czas_naprawy
				)
			
			WHEN Not Matched By Source
			Then
				DELETE
			;


Drop View vETLDimAwarie;