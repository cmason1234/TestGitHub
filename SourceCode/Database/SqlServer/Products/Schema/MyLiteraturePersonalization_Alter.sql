USE [Products]

if NOT EXISTS(select * from sys.columns where Name = N'CreatedViaV2'  
            and Object_ID = Object_ID(N'MyLiteraturePersonalization'))
    alter table MyLiteraturePersonalization add CreatedViaV2 bit not null default 0
	
go
	
	
