use Trains_3
go

-- table needed to convert English month and weekday names to Polish names
If (object_id('dbo.Data_temp') is not null) DROP TABLE dbo.Data_temp;
CREATE TABLE Data_temp(
    Id_daty int identity(1,1) PRIMARY KEY,
	Data datetime,
    Rok int check(Rok>=1990 AND Rok<=2022) not NULL,
    Miesiac varchar(15) NOT NULL,
    Numer_miesiaca int CHECK(Numer_miesiaca>=1 AND Numer_miesiaca<=12) NOT NULL,
    Dzien int Check(Dzien>=1 AND Dzien<=31) not NULL,
    Dzien_tygodnia varchar(15) Not NULL,
    Numer_dnia_tygodnia int Check(Numer_dnia_tygodnia>=1 AND Numer_dnia_tygodnia<=7) NOT NULL
);



-- Fill DimDates Lookup Table
-- Step a: Declare variables use in processing
Declare @StartDate date; 
Declare @EndDate date;

-- Step b:  Fill the variable with values for the range of years needed
SELECT @StartDate = '2000-01-01', @EndDate = '2022-12-31';

-- Step c:  Use a while loop to add dates to the table
Declare @DateInProcess datetime = @StartDate;

While @DateInProcess <= @EndDate
	Begin
	--Add a row into the date dimension table for this date
		Insert Into [dbo].[Data_temp] 
		( [Data]
		, [Rok]
		, [Miesiac]
		, [Numer_miesiaca]
		, [Dzien]
		, [Dzien_tygodnia]
		, [Numer_dnia_tygodnia]

		)
		Values ( 
			@DateInProcess -- [Date]
		  , Cast( Year(@DateInProcess) as varchar(4)) -- [Year]
		  , Cast( DATENAME(month, @DateInProcess) as varchar(10)) -- [Month]
		  , Cast( Month(@DateInProcess) as int) -- [MonthNo]
		  , Cast( Day(@DateInProcess) as int) -- [Dzien]
		  , Cast( DATENAME(dw,@DateInProcess) as varchar(15)) -- [DayOfWeek]
		  , Cast( DATEPART(dw, @DateInProcess) as int) -- [DayOfWeekNo]
		  
		);  
		-- Add a day and loop again
		Set @DateInProcess = DateAdd(d, 1, @DateInProcess);
	End


If (object_id('vETLDimDatesData') is not null) Drop View vETLDimDatesData;
go
CREATE VIEW vETLDimDatesData
AS
SELECT 
	dd.Id_daty
	, dd.Data
	, dd.Rok
	,CASE
		WHEN dd.Miesiac = 'January' THEN 'Styczen'
		WHEN dd.Miesiac = 'February' THEN 'Luty'
		WHEN dd.Miesiac = 'March' THEN 'Marzec'
		WHEN dd.Miesiac = 'April' THEN 'Kwiecien'
		WHEN dd.Miesiac = 'May' THEN 'Maj'
		WHEN dd.Miesiac = 'June' THEN 'Czerwiec'
		WHEN dd.Miesiac = 'July' THEN 'Lipiec'
		WHEN dd.Miesiac = 'August' THEN 'Sierpien'
		WHEN dd.Miesiac = 'September' THEN 'Wrzesien'
		WHEN dd.Miesiac = 'October' THEN 'Pazdziernik'
		WHEN dd.Miesiac = 'November' THEN 'Listopad'
		WHEN dd.Miesiac = 'December' THEN 'Grudzien'
	END AS Nazwa_miesiaca
	, dd.Numer_miesiaca
	, dd.Dzien
	,CASE
		WHEN dd.Dzien_tygodnia = 'Monday' THEN 'Poniedzialek'
		WHEN dd.Dzien_tygodnia = 'Tuesday' THEN 'Wtorek'
		WHEN dd.Dzien_tygodnia = 'Wednesday' THEN 'Sroda'
		WHEN dd.Dzien_tygodnia = 'Thursday' THEN 'Czwartek'
		WHEN dd.Dzien_tygodnia = 'Friday' THEN 'Piatek'
		WHEN dd.Dzien_tygodnia = 'Saturday' THEN 'Sobota'
		WHEN dd.Dzien_tygodnia = 'Sunday' THEN 'Niedziele'
	END AS Nazwa_dnia_tygodnia
	, dd.Numer_dnia_tygodnia
FROM Data_temp as dd;

MERGE INTO Data as DW
	USING vETLDimDatesData as DB
		ON DW.Data = DB.Data
		AND DW.Rok = DB.Rok
		AND DW.Miesiac = DB.Nazwa_miesiaca
		AND DW.Numer_miesiaca = DB.Numer_miesiaca
		AND DW.Dzien = DB.Dzien
		AND DW.Dzien_tygodnia = DB.Nazwa_dnia_tygodnia
		AND DW.Numer_dnia_tygodnia = DB.Numer_dnia_tygodnia

			WHEN Not Matched
			THEN
				INSERT
				Values (
					DB.Data
					, DB.Rok
					, DB.Nazwa_miesiaca
					, DB.Numer_miesiaca
					, DB.Dzien
					, DB.Nazwa_dnia_tygodnia
					, DB.Numer_dnia_tygodnia
				)
			
			WHEN Not Matched By Source
			Then
				DELETE
			;

Drop View vETLDimDatesData;

DROP TABLE dbo.Data_temp


-- select * from Data