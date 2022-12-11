use Trains_3_schema
SELECT * FROM Maszyni�ci

INSERT INTO Maszyni�ci VALUES
	('11223344556','Micha�', 'Kuprianowicz' , 'Mezczyzna'),
	('99887766554','Krzysztof', 'Nazar','Mezczyzna'),
	('12345678901', 'Anna', 'S�owik','Kobieta');

INSERT INTO Stacje VALUES
	(1,'Bydgoszcz','G��wna',1994),
	(2,'Gda�sk','Wrzeszcz',1991),
	(3,'Warszawa','Centralna',1990);

/*
INSERT INTO Stacje VALUES
	(4,'Bydgoszcz','G��wna',2000),
	(5,'Gda�sk','Wrzeszcz',2000);
*/


INSERT INTO Trasy VALUES
	(1, 1,2, 123),
	(2, 2,1, 333),
	(3, 2,3, 43),
	(4, 1,3, 34),
	(5, 3,1, 212);

INSERT INTO Poci�gi VALUES
	(1,'Intercity','Elektronika'),
	(2,'Regio','W�giel'),
	(3,'EIP','Poczta');


CREATE TABLE Przejazdy(
    Id_przejazdu int PRIMARY KEY,
    PESEL varchar(11) FOREIGN KEY REFERENCES Maszyni�ci(PESEL) NOT NULL,
    Id_poci�gu int FOREIGN KEY REFERENCES Poci�gi(Id_poci�gu) NOT NULL,
    Id_trasy int FOREIGN KEY REFERENCES Trasy(Id_trasy) NOT NULL,
    Planowanego_czasu_przyjazdu DateTime NOT NULL,
    Rzeczywstego_czasu_przyjazdu DateTime  NOT NULL, 
    Max_liczba_miejsc int NOT NULL,  
    Max_�adowno�� int NOT NULL
);

INSERT INTO Przejazdy VALUES
	(0,'11223344556',1,1,'2022-10-08 12:30','2022-10-08 12:45',200,5000),
	(3,'99887766554',2,2,'2022-10-09 14:30','2022-10-08 14:30',300,6000),
	(9,'12345678901',3,3,'2022-10-10 15:00','2022-10-08 20:45',400,7000);



INSERT INTO Awarie VALUES
	(1,3,'2022-10-10 17:00');



	
use Trains_3_schema
go

BULK INSERT dbo.Poci�gi
    FROM 'C:\Informatyka\5 SEMESTR\DW HD\Task 5\Kod SQL task 5\DataWarehouseLabSQLCode\ETL_data\trains0.csv'
    WITH
    (
	DATAFILETYPE = 'char',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    TABLOCK
    )
