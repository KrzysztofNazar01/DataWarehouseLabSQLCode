use Trains_3_schema 
SELECT * FROM Maszynisci;
SELECT * FROM Stacje;
SELECT * FROM Trasy;
SELECT * FROM Pociagi;
SELECT * FROM PrzejazdyDB;
SELECT * FROM PrzejazdySheet;
SELECT * FROM AwarieDB;
SELECT * FROM AwarieSheet;



use Trains_3_schema 
SELECT * FROM Maszynisci order by PESEL;
SELECT * FROM PrzejazdyDB order by Id_maszynisty;

use Trains_3
SELECT * FROM Maszynisci order by Id_maszynisty;



use Trains_3_schema 
SELECT * FROM AwarieDB;
SELECT * FROM AwarieSheet;
SELECT * FROM PrzejazdyDB;
use Trains_3
SELECT * FROM Przejazdy;


use Trains_3_schema 
SELECT * FROM PrzejazdyDB order by Id_przejazdu;
use Trains_3
SELECT * FROM Przejazdy order by Id_przejazdu;