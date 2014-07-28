USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateZipDistancesCanada]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateZipDistancesCanada]
GO

CREATE procedure [dbo].[UpdateZipDistancesCanada]
	@inzip nvarchar(8)
		
as
declare @inlat float
declare @inlong float

declare @longFudge float
declare @latDiff float
declare @longDiff float
declare @maxDistance float

set @maxDistance = '100'

begin transaction
select @inlat = latitude, @inlong = longitude from rheemdb..postalcode where postalcode = ltrim(rtrim(@inzip))

set @longFudge = abs((90 - @inlat) / 90.0) * 60
set @latDiff = @maxDistance / 60 
set @longDiff = @maxDistance / @longFudge 



create table #TempCanadaZipLoc (
		postalcodetemp char(10),
postalCode1 char(10),



	)
insert into #TempCanadaZipLoc
select distinct (LEFT(replace(PostalCode, ' ',''), LEN(postalcode) - 4)) as postalcodetemp,
--, sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2)) as distance 
(LEFT(replace(@inzip, ' ',''), LEN(@inzip) - 4)) as postalCode1
from rheemdb..postalcode

      where 
   latitude > @inlat - @latDiff and
   latitude < @inlat + @latDiff and 
   longitude > @inlong - @longDiff and
   longitude < @inlong + @longDiff 
--and co.radius >= sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2)) 
and sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2))  < @maxDistance 
and len((LEFT(replace(PostalCode, ' ',''), LEN(postalcode) - 4))) >1






insert into [postalcodedata].[dbo].[PostalCodeDistances] 
select postalcode1 as PostalCode1, postalcodetemp as PostalCode2, null as distance
 from #TempCanadaZipLoc



commit