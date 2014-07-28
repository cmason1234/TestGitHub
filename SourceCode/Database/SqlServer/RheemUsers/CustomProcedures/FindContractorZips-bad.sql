USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FindContractorZips-bad]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[FindContractorZips-bad]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindContractorZips-bad] 
	-- Add the parameters for the stored procedure here
	@OrganizationID uniqueidentifier
		
as
BEGIN
	declare @inzip char(16)
	declare @inlat float
	declare @inlong float
	declare @longFudge float
	declare @latDiff float
	declare @longDiff float
	declare @maxDistance float
	declare @tzip char(16)
	declare @tcity varchar(2048)
	declare @t2city varchar(50)
	declare @county char(25)
	declare @tstate char(2)
	declare @tsel int
	declare @tdist float
	declare @idist int 
	declare @cnt int


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
			create table #TempZipLoc (
				postalcode char(10),
				city varchar(60),
				county varchar(50),
				stateorprovince char(2),
				selected int,
				distance float
			)
			
			insert into #TempZipLoc
			select postalcode, city, county, stateorprovincecode, 1 as selected,
				sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2)) 
				as distance 
				from rheemdb..postalcode where 
				latitude > @inlat - @latDiff and
				latitude < @inlat + @latDiff and longitude > @inlong - @longDiff and
				longitude < @inlong + @longDiff 
				/*
				and sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2)) <= @maxDistance
				*/

			update #TempZipLoc set selected = 0 where 
				datalength(rtrim(postalcode)) <> datalength(rtrim(@inzip))

			delete from #tempziploc where distance > @maxDistance
			insert into #TempZipLoc
			select postalcode, city, county, stateorprovincecode, 1 as selected,
				sqrt(power((latitude - @inlat) * 60, 2) + power((longitude - @inlong) * @longFudge, 2)) 
				as distance 
				from rheemdb..postalcode where
				postalcode in (select postalcode from rheemusers..contractorZipCodeCoverage where
				organizationID = @organizationID  and Exclude = 0)
			update #TempZipLoc set selected = 0 where 
				postalcode in (select postalcode from rheemusers..contractorZipCodeCoverage where
				organizationID = @organizationID and Exclude = 1)
			create table #TempZipLoc2 (
				postalcode char(10),
				city varchar(2048),
				county char(25),
				stateorprovince char(2),
				selected int,
				distance int
			)
			
			declare inp_cursor scroll cursor
			
			for select * from #tempziploc order by postalcode, city

			open inp_cursor
			fetch next from inp_cursor into @tzip, @tcity, @county, @tstate, @tsel, @tdist
			while (@@fetch_status <> -1)
			begin
				select @cnt = count(*) from #tempziploc2 where postalcode = @tzip
				if @cnt > 0 
					 update #tempziploc2 set city = rtrim(city) + ', ' + rtrim(@tcity) where
					postalcode = @tzip
				else
				insert into #tempziploc2 (postalcode, city, county, stateorprovince,
					selected, distance) values (@tzip, @tcity, @county, 
					@tstate, @tsel, @tdist)

				fetch next from inp_cursor into @tzip, @tcity, @county, @tstate, @tsel, @tdist
			end
			close inp_cursor
			deallocate inp_cursor
			select * from #tempziploc2 order by postalcode
		rollback

		end
	end
END
GO
