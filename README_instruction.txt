Order of excecution:

DATABASE
- create schema tables
	- Stacje
	- Trasy
	- Maszynisci
	- Pociagi
	- Awarie
	- Przejazdy
- insert to schema


DATAWAREHOUSE
- Create DW tables:
	- Czas
	- Daty
- inserts to Czas na Daty
	- Czas (ETL)
	- Daty (ETL)
- Create the rest of the DW tables:
	- Stacje
	- Trasy
	- Maszynisci
	- Pociagi
	- Przejazdy
	- Awarie



TODO:
// jedna awaria moze wystąpic w jednym przejezdzie (bo jest problem z Id_awarii jako PK w łączeniu Sheeta z DB)

