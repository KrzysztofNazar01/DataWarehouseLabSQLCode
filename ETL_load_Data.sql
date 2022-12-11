use Trains_3
go

drop table DimDate

CREATE TABLE DimDate
(
    DateKey INTEGER IDENTITY(1,1) PRIMARY KEY,
    Date datetime unique,
	Year varchar(4),
	Month varchar(10),
	MonthNo int,
	DayOfWeek varchar(15),
	DayOfWeekNo int
)
GO


use Trains_3
go

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
		Insert Into [dbo].[DimDate] 
		( [Date]
		, [Year]
		, [Month]
		, [MonthNo]
		, [DayOfWeek]
		, [DayOfWeekNo]

		)
		Values ( 
		  @DateInProcess -- [Date]
		  , Cast( Year(@DateInProcess) as varchar(4)) -- [Year]
		  , Cast( DATENAME(month, @DateInProcess) as varchar(10)) -- [Month]
		  , Cast( Month(@DateInProcess) as int) -- [MonthNo]
		  , Cast( DATENAME(dw,@DateInProcess) as varchar(15)) -- [DayOfWeek]
		  , Cast( DATEPART(dw, @DateInProcess) as int) -- [DayOfWeekNo]
		  
		);  
		-- Add a day and loop again
		Set @DateInProcess = DateAdd(d, 1, @DateInProcess);
	End
go


-- insert into holidays and vacations
-------------------------------------------------------------

-- auxiliary tables should be created first!


If (object_id('vETLDimDatesData') is not null) Drop View vETLDimDatesData;
go

CREATE VIEW vETLDimDatesData
AS
SELECT 
	dd.DateKey
	, dd.Date
	, dd.Year
	, dd.Month
	, dd.MonthNo
	, dd.DayOfWeek
	, dd.DayOfWeekNo
FROM DimDate as dd
go

-- SELECT * from DimDate;

Drop View vETLDimDatesData;
