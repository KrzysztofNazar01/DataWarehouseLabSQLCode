use Trains_3_schema
SELECT * FROM Maszyniœci

INSERT INTO Maszyniœci VALUES
	('11223344556','Micha³ Kuprianowicz' , 'Mê¿czyzna'),
	('99887766554','Krzysztof Nazar','Mê¿czyzna'),
	('12345678901', 'Anna S³owik','Kobieta');

INSERT INTO Stacje VALUES
	(1,'Bydgoszcz','G³ówna',1994),
	(2,'Gdañsk','Wrzeszcz',1991),
	(3,'Warszawa','Centralna',1990);

--INSERT INTO Stacje VALUES
--(4,'Bydgoszcz','G³ówna',2000);



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


INSERT INTO Przejazdy VALUES
	(1,'11223344556',1,1,'2022-10-08 12:30','2022-10-08 12:45',200,5000),
	(2,'99887766554',2,2,'2022-10-09 14:30','2022-10-08 14:30',300,6000),
	(3,'12345678901',3,3,'2022-10-10 15:00','2022-10-08 20:45',400,7000);

INSERT INTO Awarie VALUES
	(1,3,'2022-10-10 17:00');