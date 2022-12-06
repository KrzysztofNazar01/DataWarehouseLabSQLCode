use Trains_3 EXEC sp_changedbowner 'sa'
SELECT * FROM Maszyniœci

INSERT INTO Maszyniœci VALUES
	('Micha³ Kuprianowicz' , 'Mê¿czyzna','11223344556'),
	('Krzysztof Nazar','Mê¿czyzna','99887766554'),
	('Anna S³owik','Kobieta','12345678901');

INSERT INTO Stacje VALUES
	('Bydgoszcz','G³ówna',2016,1),
	('Gdañsk','Wrzeszcz',2019,0),
	('Gdañsk','Wrzeszcz',2022,1),
	('Warszawa','Centralna',1990,1);

INSERT INTO Trasy VALUES
	(1,2),
	(2,1),
	(2,3),
	(1,3),
	(3,1);

INSERT INTO Poci¹gi VALUES
	('Intercity','Elektronika'),
	('Regio','Wêgiel'),
	('EIP','Poczta');


INSERT INTO Data VALUES
	(2022,'Listopad',11,1,'Wtorek',2),
	(2022,'Listopad',11,2,'Œroda',3),
	(2022,'Listopad',11,3,'Czwartek',4);

INSERT INTO Czas VALUES
	(15,0),
	(16,30),
	(17,0),
	(17,30);

INSERT INTO Przejazdy VALUES
	(1,1,1,1,2,3,30,0,100,200,50,1000,4000),
	(2,2,2,2,1,4,150,1,150,200,75,3000,5000),
	(3,3,3,3,3,3,NULL,0,200,250,80,2000,3000);

INSERT INTO Awarie VALUES
	(2,2,2,1,2);