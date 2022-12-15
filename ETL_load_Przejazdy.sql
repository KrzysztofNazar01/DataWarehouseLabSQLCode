/*

Use Trains_3_schema
Select * from PrzejazdyDB
Select * from PrzejazdySheet

Use Trains_3
Select * from Przejazdy

Use Trains_3
Select * from Maszynisci

Use Trains_3_schema
Select * from Pociagi

Use Trains_3_schema
Select * from PrzejazdyDB
order by Id_pociagu desc

Use Trains_3
Select * from Pociagi

*/


USE Trains_3
If (object_id('vETLDimPrzejazdy') is not null) Drop View vETLDimPrzejazdy;
go
CREATE VIEW vETLDimPrzejazdy
AS
SELECT DISTINCT
	table1.[Id_przejazdu],
	table1.[Id_maszynisty],
	table1.[Id_pociagu],
	table1.[Id_trasy],
	RW.[Id_daty] as Id_daty_rzeczywistego_wyjazdu,
	--RW_G.[Id_czasu] as Id_czasu_rzeczywistego_wyjazdu,
	--PP.[Id_daty] as Id_daty_planowanego_przyjazdu,
	PP_G.[Id_czasu] as Id_czasu_planowanego_przyjazdu,
	--RP.[Id_daty] as Id_daty_rzeczywstego_przyjazdu,
	RP_G.[Id_czasu] as Id_czasu_rzeczywistego_przyjazdu,
	table2.[Opoznienie],
	table2.[Czy_wystapila_awaria],
	table2.[Liczba_zajetych_miejsc],
	table2.[Max_liczba_miejsc],
	Procent_zajetych_miejsc = CAST(100*table2.[Liczba_zajetych_miejsc]/table2.[Max_liczba_miejsc] AS INT),
	table2.[Masa_przewozonego_towaru],
	table2.[Max_ladownosc]

	FROM Trains_3_schema.dbo.PrzejazdyDB as table1
	JOIN Trains_3_schema.dbo.PrzejazdySheet as table2 ON table1.Id_przejazdu = table2.Id_przejazdu
	JOIN dbo.Data as RW ON CONVERT(VARCHAR(10), RW.Data, 111) = CONVERT(VARCHAR(10), table1.[Data_rzeczywisty_wyjazd], 111)
	JOIN dbo.Czas as RW_G ON RW_G.Godzina = DATEPART(HOUR, table1.[Data_rzeczywisty_wyjazd])
	JOIN dbo.Czas as RW_M ON RW_M.Minuta = DATEPART(MINUTE, table1.[Data_rzeczywisty_wyjazd])
	--JOIN dbo.Data as PP ON CONVERT(VARCHAR(10), PP.Data, 111) = CONVERT(VARCHAR(10), table1.[Data_planowany_przyjazd], 111)
	JOIN dbo.Czas as PP_G ON PP_G.Godzina = DATEPART(HOUR, table1.[Data_planowany_przyjazd])
	JOIN dbo.Czas as PP_M ON PP_M.Minuta = DATEPART(MINUTE, table1.[Data_planowany_przyjazd])
	--JOIN dbo.Data as RP ON CONVERT(VARCHAR(10), RP.Data, 111) = CONVERT(VARCHAR(10), table1.[Data_rzeczywisty_przyjazd], 111)
	JOIN dbo.Czas as RP_G ON RP_G.Godzina = DATEPART(HOUR, table1.[Data_rzeczywisty_przyjazd])
	JOIN dbo.Czas as RP_M ON RP_M.Minuta = DATEPART(MINUTE, table1.[Data_rzeczywisty_przyjazd])

Where
	RW_G.[Id_czasu] = RW_M.[Id_czasu]
	AND 
	PP_G.[Id_czasu] = PP_M.[Id_czasu]
	AND 
	RP_G.[Id_czasu] = RP_M.[Id_czasu]

go

Select * from vETLDimPrzejazdy
order by Id_maszynisty desc


MERGE INTO Przejazdy as DW
	USING vETLDimPrzejazdy as DB
		ON  DW.Id_maszynisty = DB.Id_maszynisty
			AND DW.Id_pociagu = DB.Id_pociagu
			AND DW.Id_trasy = DB.Id_trasy
			AND DW.Id_daty_wyjazdu = DB.Id_daty_rzeczywistego_wyjazdu
			AND DW.Id_planowanego_czasu_przyjazdu = DB.Id_czasu_planowanego_przyjazdu
			AND DW.Id_rzeczywstego_czasu_przyjazdu = DB.Id_czasu_rzeczywistego_przyjazdu
			AND DW.Opoznienie = DB.Opoznienie
			/*
			AND DW.Czy_wystapila_awaria = DB.Czy_wystapila_awaria
			AND DW.Liczba_zajetych_miejsc = DB.Liczba_zajetych_miejsc
			AND DW.Max_liczba_miejsc = DB.Max_liczba_miejsc
			AND DW.Procent_zajetych_miejsc = DB.Procent_zajetych_miejsc
			AND DW.Masa_towaru = DB.Masa_przewozonego_towaru
			AND DW.Max_ladownosc = DB.Max_ladownosc
			*/
			WHEN Not Matched
			THEN
				INSERT
				Values (
					  DB.Id_maszynisty
					, DB.Id_pociagu
					, DB.Id_trasy
					, DB.Id_daty_rzeczywistego_wyjazdu
					, DB.Id_czasu_planowanego_przyjazdu
					, DB.Id_czasu_rzeczywistego_przyjazdu
					, DB.Opoznienie
					, DB.Czy_wystapila_awaria
					, DB.Liczba_zajetych_miejsc
					, DB.Max_liczba_miejsc
					, DB.Procent_zajetych_miejsc
					, DB.Masa_przewozonego_towaru
					, DB.Max_ladownosc
				)
			;


Drop View vETLDimPrzejazdy;

/*

Use Trains_3
Select * from Przejazdy

*/
