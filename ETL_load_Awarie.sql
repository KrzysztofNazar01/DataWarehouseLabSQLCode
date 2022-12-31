
USE Trains_3
GO 
If (object_id('vETLDimAwarie') is not null) Drop View vETLDimAwarie;
go
CREATE VIEW vETLDimAwarie
AS
SELECT DISTINCT
	A_DB.[Id_awarii], -- only to debug
	A_DB.[Id_przejazdu],
	SD.[Id_daty],
	G.[Id_czasu] as Id_czasu,
	A_SH.[Czy_naprawiono_na_miejscu],
	A_SH.[Czas_naprawy]

	FROM Trains_3_schema.dbo.AwarieDB as A_DB
	JOIN Trains_3_schema.dbo.AwarieSheet as A_SH ON A_DB.Id_awarii = A_SH.Id_awarii
	
	JOIN Trains_3_schema.[dbo].PrzejazdyDB as P_DB ON P_DB.Id_przejazdu = A_DB.Id_przejazdu --wyszukc przejazd w bazie danych
	JOIN [Trains_3].[dbo].[Przejazdy] as P_DW ON P_DW.Id_pociagu = P_DB.Id_pociagu 
	
	
	JOIN dbo.Czas as G ON G.Godzina = DATEPART(HOUR, A_DB.Data_awarii)
	JOIN dbo.Czas as M ON M.Minuta = DATEPART(MINUTE, A_DB.Data_awarii)
	JOIN dbo.Data as SD ON CONVERT(VARCHAR(10), SD.Data, 111) = CONVERT(VARCHAR(10), A_DB.[Data_awarii], 111)
Where
	G.[Id_czasu] = M.[Id_czasu]	
go

select * from vETLDimAwarie
/*

select * from vETLDimAwarie

*/

MERGE INTO Awarie as DW
	USING vETLDimAwarie as DB
		ON  DW.Id_przejazdu = DB.Id_przejazdu
			AND DW.Id_daty_awarii = DB.Id_daty
			AND DW.Id_czasu_awarii = DB.Id_czasu
			AND DW.Czy_naprawiono_na_miejscu = DB.Czy_naprawiono_na_miejscu
			AND DW.Czas_naprawy = DB.Czas_naprawy
			WHEN Not Matched
			THEN
				INSERT
				Values (
					DB.Id_przejazdu
					, DB.Id_daty
					, DB.Id_czasu
					, DB.Czy_naprawiono_na_miejscu
					, DB.Czas_naprawy
				)
		
			;


Drop View vETLDimAwarie;

/*

use Trains_3
select * from Awarie

*/