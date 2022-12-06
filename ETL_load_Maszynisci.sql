use Trains_3_schema
go

BULK INSERT dbo.Maszyniœci
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

Select * from Maszyniœci


