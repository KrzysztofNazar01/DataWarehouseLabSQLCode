use Trains_3_schema
SELECT * FROM Maszyniœci

INSERT INTO Maszyniœci VALUES
	('11223344556','Micha³', 'Kuprianowicz' , 'Mezczyzna'),
	('99887766554','Krzysztof', 'Nazar','Mezczyzna'),
	('12345678901', 'Anna', 'S³owik','Kobieta');

INSERT INTO Stacje VALUES
	(1,'Bydgoszcz','G³ówna',1994),
	(2,'Gdañsk','Wrzeszcz',1991),
	(3,'Warszawa','Centralna',1990);

/*
INSERT INTO Stacje VALUES
	(4,'Bydgoszcz','G³ówna',2000),
	(5,'Gdañsk','Wrzeszcz',2000);
*/


INSERT INTO Trasy VALUES
	(1, 1,2, 123),
	(2, 2,1, 333),
	(3, 2,3, 43),
	(4, 1,3, 34),
	(5, 3,1, 212);

INSERT INTO Poci¹gi VALUES
	(1,'Intercity','Elektronika'),
	(2,'Regio','Wêgiel'),
	(3,'EIP','Poczta');


CREATE TABLE Przejazdy(
    Id_przejazdu int PRIMARY KEY,
    PESEL varchar(11) FOREIGN KEY REFERENCES Maszyniœci(PESEL) NOT NULL,
    Id_poci¹gu int FOREIGN KEY REFERENCES Poci¹gi(Id_poci¹gu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
    Planowanego_czasu_przyjazdu DateTime NOT NULL,
    Rzeczywstego_czasu_przyjazdu DateTime  NOT NULL, 
    Max_liczba_miejsc int NOT NULL,  
    Max_³adownoœæ int NOT NULL
);

INSERT INTO Przejazdy VALUES
	(0,'11223344556',1,1,'2022-10-08 12:30','2022-10-08 12:45',200,5000),
	(3,'99887766554',2,2,'2022-10-09 14:30','2022-10-08 14:30',300,6000),
	(9,'12345678901',3,3,'2022-10-10 15:00','2022-10-08 20:45',400,7000);



INSERT INTO Awarie VALUES
	(1,3,'2022-10-10 17:00');



	
use Trains_3_schema
go

BULK INSERT dbo.Poci¹gi
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\trains0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )
