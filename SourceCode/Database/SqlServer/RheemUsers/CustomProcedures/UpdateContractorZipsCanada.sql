USE [rheemusers]
GO

ALTER procedure [dbo].[UpdateContractorZipsCanada]
	@OrganizationID uniqueidentifier
		
as
declare @inzip char(5)
declare @inlat float
declare @inlong float
declare @longFudge float
declare @latDiff float
declare @longDiff float
declare @maxDistance float
declare @tzip char(16)
declare @tsel int
declare @cnt int

set QUOTED_IDENTIFIER ON

if @OrganizationID is not null
begin 
delete from [postalcodedata].[dbo].[ContractorZipCodes] where organizationid = @OrganizationID
insert into [postalcodedata].[dbo].[ContractorZipCodes] select newid() as ContractorZipCodeID, CAST(UPPER(@OrganizationID) AS uniqueidentifier) as OrganizationID, '00000' as ZipCode
end

select distinct @maxDistance = radius, @inzip = dbo.postalpart(a.postalcode), @inlat =
	latitude, @inlong = longitude
	from rheemusers..ContractorOrganization co, rheemdb..postalcode p, rheemusers..Address a
	 where 
co.OrganizationID = @organizationID and
co.PrimaryAddressID = a.AddressID and 
dbo.postalpart(a.postalcode) = p.postalcode

if datalength(@inzip) > 0 and @maxDistance > 0 
begin

    if @inlat <> 0
    begin
	set @longFudge = abs((90 - @inlat) / 90.0) * 60
	set @latDiff = @maxDistance / 60 
	set @longDiff = @maxDistance / @longFudge 

	begin transaction
	create table #TempCanadaZipLoc (
		postalcode char(10),
selected int,
distance float


	)
	

--select round(1.222222, 2)
	insert into #TempCanadaZipLoc
	select Distinct 
postalcode, 
1 as selected, 
0 as distance
--round(sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2)), 1) as distance
--sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2)) as distance
 		from rheemdb..postalcode where 
		latitude > @inlat - @latDiff and
		latitude < @inlat + @latDiff and longitude > @inlong - @longDiff and
		longitude < @inlong + @longDiff 
		/*
		and sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2)) <= @maxDistance
		*/

	update #TempCanadaZipLoc set selected = 0 where 
		datalength(rtrim(postalcode)) <> datalength(rtrim(@inzip))

	delete from #TempCanadaZipLoc where distance > @maxDistance

select distinct postalcode
into #tempDupsDealerLoc 
from #tempCanadaZiploc
order by postalcode



DECLARE @tempID AS uniqueidentifier
    SET @tempID = CAST(UPPER(@OrganizationID) AS uniqueidentifier)

if @OrganizationID is not null
begin 
--create table #TempCanadaZipLocLast (
--		postalcode char(10)
--	)
insert into [postalcodedata].[dbo].[ContractorZipCodes] 
select newid() as ContractorZipCodeID, @OrganizationID as OrganizationID, postalcode as zipcode from #tempDupsDealerLoc --order by postalcode
delete from  [postalcodedata].[dbo].[ContractorZipCodes] where zipcode = '00000'
end
commit
drop table #tempCanadaziploc
drop table #tempDupsDealerLoc

end
end
