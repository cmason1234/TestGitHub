USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorsReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorsReport]
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
CREATE PROCEDURE [dbo].[GetDistributorsReport] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueIdentifier, 
	
	@OrganizationName varchar(50), 
	@City varchar(50), 
	@State varchar(50), 
	@PostalCode varchar(50), 
	@BrandName varchar(50), 
	@OracleAccountNumber varchar(50), 

	@AC bit,
	@WHTank bit,
	@WHTankless bit,
	@WHSolar bit,
	@WHHeatPump bit,
	@Generator bit,
	@PoolSpa bit,
	@Parts bit,

	@ACDisabled bit,
	@WHTankDisabled bit,
	@WHTanklessDisabled bit,
	@WHSolarDisabled bit,
	@WHHeatPumpDisabled bit,
	@GeneratorDisabled bit,
	@PoolSpaDisabled bit,
	@PartsDisabled bit,
	
	@Disabled bit, 	
	@COOPEligible bit,
	@Corporate bit,
	@ProStockStores bit,
	@SingleLine bit,
	@ScheduledPay bit,
	@ManufacturedHousing bit
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select *
	  from rheemusers..MyOrganizations mo 
	    inner join rheemusers..organization o on 
			mo.OrganizationID = o.OrganizationId and 
  		    o.OrganizationType  = 'Distributor' 
  	    inner join rheemusers..DistributorOrganization do on 
			o.OrganizationID = do.OrganizationId 
		inner join rheemusers..Address a on 
			do.primaryAddressId = a.AddressID
	  where 
		mo.personID         = @PersonID and 

		(@OrganizationName IS NULL OR o.OrganizationName like '%' +  @OrganizationName + '%' ) and
		(@city IS NULL             OR a.city             like '%' +  @City + '%' ) and
		(@State IS NULL            OR a.State            like '%' +  @State + '%' ) and
		(@PostalCode IS NULL       OR a.PostalCode       like '%' +  @PostalCode + '%' ) and
		(@OracleAccountNumber IS NULL  OR do.OracleAccountNumber like '%' +  @OracleAccountNumber + '%' ) and		

		(@BrandName IS NULL OR o.OrganizationID in (
			select ob.OrganizationID from rheemusers..OrganizationBrand ob , rheemdb..Brand b
			   where 
			ob.organizationid=o.OrganizationID and 
			ob.brandID = b.BrandId and 
			b.BrandName=@BrandName)  ) and

		(@AC IS NULL         OR AC         = @AC ) and
		(@WHTank IS NULL     OR WHTank     = @WHTank ) and
		(@WHTankless IS NULL OR WHTankless = @WHTankless ) and
		(@WHSolar IS NULL    OR WHSolar    = @WHSolar ) and
		(@WHHeatPump IS NULL OR WHHeatPump = @WHHeatPump ) and
		(@Generator IS NULL  OR Generator  = @Generator ) and
		(@PoolSpa IS NULL    OR PoolSpa    = @PoolSpa ) and
		(@Parts IS NULL      OR Parts      = @Parts ) and
		
		(@ACDisabled IS NULL         OR ACDisabled         = @ACDisabled) and
		(@WHTankDisabled IS NULL     OR WHTankDisabled     = @WHTankDisabled) and
		(@WHTanklessDisabled IS NULL OR WHTanklessDisabled = @WHTanklessDisabled) and
		(@WHSolarDisabled IS NULL    OR WHSolarDisabled    = @WHSolarDisabled) and
		(@WHHeatPumpDisabled IS NULL OR WHHeatPumpDisabled = @WHHeatPumpDisabled) and
		(@GeneratorDisabled IS NULL  OR GeneratorDisabled  = @GeneratorDisabled) and
		(@PoolSpaDisabled IS NULL    OR PoolSpaDisabled    = @PoolSpaDisabled) and
		(@PartsDisabled IS NULL      OR PartsDisabled      = @PartsDisabled) and

		(
		(@Disabled            IS NULL and (do.Disabled is null or do.disabled='0')) or 
		(@Disabled            IS NOT NULL and (do.Disabled =@Disabled))
		) and 		

		(@COOPEligible        IS NULL OR COOPEligible        = @COOPEligible) and
		(@Corporate           IS NULL OR Corporate           = @Corporate) and
		(@ProStockStores      IS NULL OR ProStockStores      = @ProStockStores) and
		(@SingleLine          IS NULL OR SingleLine          = @SingleLine) and
		(@ScheduledPay        IS NULL OR ScheduledPay        = @ScheduledPay) and
		(@ManufacturedHousing IS NULL OR ManufacturedHousing = @ManufacturedHousing) 
		
	  order by o.OrganizationName

END
GO
