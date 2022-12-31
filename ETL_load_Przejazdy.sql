USE Trains_3
If (object_id('vETLDimPrzejazdy') is not null) Drop View vETLDimPrzejazdy;
go
CREATE VIEW vETLDimPrzejazdy
AS
SELECT DISTINCT
	M_DW.[Id_maszynisty],
	Poc_DW.[Id_pociagu],
	T_DW.[Id_trasy],

	RW.[Id_daty] as Id_daty_rzeczywistego_wyjazdu,
	PP_G.[Id_czasu] as Id_czasu_planowanego_przyjazdu,
	RP_G.[Id_czasu] as Id_czasu_rzeczywistego_przyjazdu,

	P_SH.[Opoznienie],
	P_SH.[Czy_wystapila_awaria],
	P_SH.[Liczba_zajetych_miejsc],
	P_SH.[Max_liczba_miejsc],
	Procent_zajetych_miejsc = CAST(100*P_SH.[Liczba_zajetych_miejsc]/P_SH.[Max_liczba_miejsc] AS INT),
	P_SH.[Masa_przewozonego_towaru],
	P_SH.[Max_ladownosc]
	

	FROM Trains_3_schema.dbo.PrzejazdyDB as P_DB
	JOIN Trains_3_schema.dbo.PrzejazdySheet as P_SH ON P_DB.Id_przejazdu = P_SH.Id_przejazdu
	JOIN Trains_3_schema.[dbo].[Maszynisci] as M_DB ON P_DB.Id_maszynisty = M_DB.PESEL --wyszukc masyzniste w bazie danych
	JOIN [Trains_3].[dbo].[Maszynisci] as M_DW ON M_DW.PESEL = M_DB.PESEL  -- a tutaj wyszukac masyzniste po atrubtyach ktore nie sa kluczem glownym, a na koniec pobrac jego klucz glowny
	
	JOIN Trains_3_schema.[dbo].[Pociagi] as Poc_DB ON P_DB.Id_pociagu = Poc_DB.Id_pociagu --wyszukc pociag w bazie danych
	JOIN [Trains_3].[dbo].[Pociagi] as Poc_DW ON Poc_DW.Typ = Poc_DB.Typ AND Poc_DW.Typ_towaru = Poc_DB.Typ_towaru AND Poc_DW.Ladownosc = Poc_DB.Ladownosc AND Poc_DW.Miejsca = Poc_DB.Miejsca -- a tutaj wyszukac pociag po atrubtyach ktore nie sa kluczem glowny, a na koniec pobrac jego klucz glowny
	
	JOIN Trains_3_schema.[dbo].[Trasy] as T_DB ON P_DB.Id_trasy = T_DB.Id_trasy --wyszukc trase w bazie danych
	JOIN [Trains_3].[dbo].[Trasy] as T_DW ON T_DW.Id_stacji_koncowej = T_DB.Id_stacji_koncowej AND T_DW.Id_stacji_poczatkowej = T_DB.Id_stacji_poczatkowej  -- a tutaj wyszukac trase po atrubtyach ktore nie sa kluczem glowny, a na koniec pobrac jego klucz glowny

	JOIN dbo.Data as RW ON CONVERT(VARCHAR(10), RW.Data, 111) = CONVERT(VARCHAR(10), P_DB.[Data_rzeczywisty_wyjazd], 111)
	JOIN dbo.Czas as RW_G ON RW_G.Godzina = DATEPART(HOUR, P_DB.[Data_rzeczywisty_wyjazd])
	JOIN dbo.Czas as RW_M ON RW_M.Minuta = DATEPART(MINUTE, P_DB.[Data_rzeczywisty_wyjazd])
	
	JOIN dbo.Czas as PP_G ON PP_G.Godzina = DATEPART(HOUR, P_DB.[Data_planowany_przyjazd])
	JOIN dbo.Czas as PP_M ON PP_M.Minuta = DATEPART(MINUTE, P_DB.[Data_planowany_przyjazd])

	JOIN dbo.Czas as RP_G ON RP_G.Godzina = DATEPART(HOUR, P_DB.[Data_rzeczywisty_przyjazd])
	JOIN dbo.Czas as RP_M ON RP_M.Minuta = DATEPART(MINUTE, P_DB.[Data_rzeczywisty_przyjazd])

Where
	RW_G.[Id_czasu] = RW_M.[Id_czasu]
	AND 
	PP_G.[Id_czasu] = PP_M.[Id_czasu]
	AND 
	RP_G.[Id_czasu] = RP_M.[Id_czasu]
go

Select * from vETLDimPrzejazdy


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
