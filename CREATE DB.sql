use Trains_3 EXEC sp_changedbowner 'sa'

Create database Trains_3

drop database Trains_3

--before deleting run this code:
alter database Trains_3 set single_user with rollback immediate


