USE Trains_3
GO 
If (object_id('vETLDimPrzejazdy') is not null) Drop View vETLDimPrzejazdy;
go
CREATE VIEW vETLDimPrzejazdy
AS
SELECT DISTINCT
	table1.[Id_przejazdu],
	table1.[Id_maszynisty],
	table1.[Id_pociągu],
	table1.[Id_trasy],
	RD.[DateKey] as Id_daty_wyjazdu,
	PA.[DateKey] as Id_planowanego_czasu_przyjazdu,
	RA.[DateKey] as Id_rzeczywstego_czasu_przyjazdu,
	table2.[Opoznienie],
	table2.[Czy_wystapila_awaria],
	table2.[Liczba_zajetych_miejsc],
	table2.[Max_liczba_miejsc],
	Procent_zajętych_miejsc = CAST(100*table2.[Liczba_zajetych_miejsc]/table2.[Max_liczba_miejsc] AS INT),
	table2.[Masa_przewozonego_towaru],
	table2.[Max_ladownosc]

	FROM Trains_3_schema.dbo.PrzejazdyDB as table1
	JOIN Trains_3_schema.dbo.PrzejazdySheet as table2 ON table1.Id_przejazdu = table2.Id_przejazdu
	JOIN dbo.DimDate as RD ON CONVERT(VARCHAR(10), RD.Date, 111) = CONVERT(VARCHAR(10), table1.[Data_rzeczywisty_wyjazd], 111)
	JOIN dbo.DimDate as PA ON CONVERT(VARCHAR(10), PA.Date, 111) = CONVERT(VARCHAR(10), table1.[Data_planowany_przyjazd], 111)
	JOIN dbo.DimDate as RA ON CONVERT(VARCHAR(10), RA.Date, 111) = CONVERT(VARCHAR(10), table1.[Data_rzeczywisty_przyjazd], 111)
go

MERGE INTO Przejazdy as DW
	USING vETLDimPrzejazdy as DB

	--TODO
		ON  DW.Id_maszynisty = DB.Id_maszynisty
			AND DW.Id_pociągu = DB.Id_pociągu
			AND DW.Id_trasy = DB.Id_trasy
			AND DW.Id_daty_wyjazdu = DB.Id_daty_wyjazdu
			AND DW.Id_planowanego_czasu_przyjazdu = DB.Id_planowanego_czasu_przyjazdu
			AND DW.Id_rzeczywstego_czasu_przyjazdu = DB.Id_rzeczywstego_czasu_przyjazdu
			AND DW.Opóźnienie = DB.Opoznienie
			AND DW.Czy_wystąpiła_awaria = DB.Czy_wystapila_awaria
			AND DW.Liczba_zajętych_miejsc = DB.Liczba_zajetych_miejsc
			AND DW.Max_liczba_miejsc = DB.Max_liczba_miejsc
			AND DW.Procent_zajętych_miejsc = DB.Procent_zajętych_miejsc
			AND DW.Masa_towaru = DB.Masa_przewozonego_towaru
			AND DW.Max_ładowność = DB.Max_ladownosc
			WHEN Not Matched
			THEN
				INSERT
				Values (
					DB.Id_maszynisty
					, DB.Id_pociągu
					, DB.Id_trasy
					, DB.Id_daty_wyjazdu
					, DB.Id_planowanego_czasu_przyjazdu
					, DB.Id_rzeczywstego_czasu_przyjazdu
					, DB.Opoznienie
					, DB.Czy_wystapila_awaria
					, DB.Liczba_zajetych_miejsc
					, DB.Max_liczba_miejsc
					, DB.Procent_zajętych_miejsc
					, DB.Masa_przewozonego_towaru
					, DB.Max_ladownosc
				)
			
			WHEN Not Matched By Source
			Then
				DELETE
			;


Drop View vETLDimPrzejazdy;
