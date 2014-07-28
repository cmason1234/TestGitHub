Use [RheemDB]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Misc5Units'  
            and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD Misc5Units int;
END


if NOT EXISTS(select * from sys.columns where Name = N'Misc6Units'  
            and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD Misc6Units int;
END

if NOT EXISTS(select * from sys.columns where Name = N'Misc5Desc'  
            and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD Misc5Desc varchar(50);
END


if NOT EXISTS(select * from sys.columns where Name = N'Misc6Desc'  
            and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD Misc6Desc varchar(50);
END

if NOT EXISTS(select * from sys.columns where Name = N'HighEffPrevYear2'  
            and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD HighEffPrevYear2 float;
END

if NOT EXISTS(select * from sys.columns where Name = N'HighEffPrevYear1'  
            and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD HighEffPrevYear1 float;
END

if NOT EXISTS(select * from sys.columns where Name = N'HighEffCurrentYear'  
            and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD HighEffCurrentYear float;
END



if NOT EXISTS(select * from sys.columns where Name = N'IndustryACSharePrevYear3'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD IndustryACSharePrevYear3 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'IndustryACSharePrevYear2'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD IndustryACSharePrevYear2 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'IndustryACSharePrevYear1'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD IndustryACSharePrevYear1 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'IndustryACShareCurrentYear'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD IndustryACShareCurrentYear float;
END


if NOT EXISTS(select * from sys.columns where Name = N'IndustryGasSharePrevYear3'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD IndustryGasSharePrevYear3 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'IndustryGasSharePrevYear2'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD IndustryGasSharePrevYear2 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'IndustryGasSharePrevYear1'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD IndustryGasSharePrevYear1 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'IndustryGasShareCurrentYear'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD IndustryGasShareCurrentYear float;
END




if NOT EXISTS(select * from sys.columns where Name = N'MarketACSharePrevYear3'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketACSharePrevYear3 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketACSharePrevYear2'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketACSharePrevYear2 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketACSharePrevYear1'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketACSharePrevYear1 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketACShareCurrentYear'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketACShareCurrentYear float;
END


if NOT EXISTS(select * from sys.columns where Name = N'MarketGasSharePrevYear3'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketGasSharePrevYear3 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketGasSharePrevYear2'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketGasSharePrevYear2 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketGasSharePrevYear1'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketGasSharePrevYear1 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketGasShareCurrentYear'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketGasShareCurrentYear float;
END

if NOT EXISTS(select * from sys.columns where Name = N'MarketCommSharePrevYear3'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketCommSharePrevYear3 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketCommSharePrevYear2'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketCommSharePrevYear2 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketCommSharePrevYear1'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketCommSharePrevYear1 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketCommShareCurrentYear'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketCommShareCurrentYear float;
END


if NOT EXISTS(select * from sys.columns where Name = N'MarketTotalSharePrevYear3'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketTotalSharePrevYear3 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketTotalSharePrevYear2'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketTotalSharePrevYear2 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketTotalSharePrevYear1'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketTotalSharePrevYear1 float;
END
if NOT EXISTS(select * from sys.columns where Name = N'MarketTotalShareCurrentYear'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD MarketTotalShareCurrentYear float;
END

if NOT EXISTS(select * from sys.columns where Name = N'R22Purchases'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD R22Purchases float Default 0
END
if NOT EXISTS(select * from sys.columns where Name = N'RetailPurchases'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD RetailPurchases float Default 0;
END

if NOT EXISTS(select * from sys.columns where Name = N'AuditFrequency'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD AuditFrequency  int NOT NULL Default 1000
END

If Not Exists(select * from sys.columns where Name = N'GDPEarningPercentage'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD GDPEarningPercentage decimal (4,3) NOT NULL default 0.013
END

If Not Exists(select * from sys.columns where Name = N'TCEarningPercentage'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD TCEarningPercentage decimal (4,3) NOT NULL default 0.007
END

If Not Exists(select * from sys.columns where Name = N'TotalEstCoopFunding'  and Object_ID = Object_ID(N'EC_Forecast'))
BEGIN
	ALTER TABLE EC_Forecast ADD TotalEstCoopFunding decimal (18,3) Null
END

GO
