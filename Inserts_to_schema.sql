use Trains_3_schema
go

BULK INSERT dbo.Stacje
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\stations0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )



BULK INSERT dbo.Maszynisci
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\drivers0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
	--FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )

BULK INSERT dbo.Pociagi
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\trains0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )




BULK INSERT dbo.AwarieDB
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\malfunction0.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )


BULK INSERT dbo.AwarieSheet
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\malfunction_sheet0.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )




BULK INSERT dbo.PrzejazdyDB
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\trainRuns0.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

BULK INSERT dbo.PrzejazdySheet
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\trainRunsSheet0.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

