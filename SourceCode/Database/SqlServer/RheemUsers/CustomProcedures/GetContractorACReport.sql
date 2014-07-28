USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorACReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorACReport]
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
CREATE PROCEDURE [dbo].[GetContractorACReport] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueIdentifier, 
	
	@OrganizationName varchar(50), 
	@City varchar(50), 
	@State varchar(50), 
	@PostalCode varchar(50), 
	
	@Country varchar(50), 	
	@ACNumber varchar(50), 

	@Email varchar(50), 
	@Website varchar(50), 
	@BrandID uniqueidentifier, 
	
	@DistributorName varchar(50), 
	@OracleAccountNumber varchar(50), 

	@RebateID uniqueidentifier,  
	@Status varchar(50), 
	@Radius integer, 
	
	@Disabled bit,
	@KwikComfort bit,
	@Nate bit,
	@ShowOnLocator bit,
	@FollowUp bit,
	@Top1 bit,
	@Top10 bit,
	@ProtectionPlus bit,
	@CashBack bit,
	@Mechanical bit,
	@Commercial bit,
	@AirTime500 bit,
					
	@DesignStar bit,
	@PersonWebSite bit,
	@RheemOrRuudWebsite bit,

	@ActivationStartDate varchar(50),
	@ActivationEndDate varchar(50),
	@TerminationStartDate varchar(50),
	@TerminationEndDate varchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select *, rheemusers.dbo.GetOrgBrandList(o.OrganizationId) BrandList
	  from rheemusers..MyOrganizations mo 
	    inner join rheemusers..organization o on 
			mo.OrganizationID = o.OrganizationId and 
  		    (o.OrganizationType = 'Contractor' or o.OrganizationType = 'Dealer')  
  	    inner join rheemusers..ContractorOrganization co on 
			o.OrganizationID = co.OrganizationId 
  	    inner join rheemusers..ContractorAC cac on 
			o.OrganizationID = cac.OrganizationId 
		inner join rheemusers..Address a on 
			co.primaryAddressId = a.AddressID
	  where 

	  mo.personID         = @PersonID and 

		(@OrganizationName IS NULL OR o.OrganizationName like '%' +  @OrganizationName + '%' ) and
		(@city             IS NULL OR a.city             like '%' +  @City + '%' ) and
		(@State            IS NULL OR a.State            like '%' +  @State + '%' ) and
		(@PostalCode       IS NULL OR a.PostalCode       like '%' +  @PostalCode + '%' ) and
		(@Country          IS NULL OR a.Country          = @Country) and
		(@ACNumber         IS NULL OR cac.DealerNumber like '%' +  @ACNumber + '%' ) and		

		(@Email            IS NULL OR co.CorporateEmail like '%' +  @Email + '%' ) and
		(@Website          IS NULL OR co.WebSite like '%' +  @Website + '%' ) and	
		(@BrandID          IS NULL OR cac.BrandID = @BrandID ) and	

		(@DistributorName  IS NULL OR cac.DistributorOrganizationID in (
			select o1.OrganizationID from rheemusers..myOrganizations mo1, rheemusers..Organization o1
				where
			mo1.PersonID = @PersonID and 
			mo1.OrganizationID = o1.OrganizationID and 
			o1.OrganizationType = 'Distributor' and 
			o1.OrganizationName like '%' + @DistributorName + '%'
		)
		) and	
	
		(@OracleAccountNumber IS NULL OR cac.DistributorOrganizationID in (
			select do2.OrganizationID from rheemusers..myOrganizations mo2, rheemusers..DistributorOrganization do2
				where
			mo2.PersonID = @PersonID and 
			mo2.OrganizationID = do2.OrganizationID and 
			do2.OracleAccountNumber =  @OracleAccountNumber
		)
		) and	

		(@RebateID IS NULL OR o.OrganizationID in (
			select OrganizationID from rheemusers..RebateProgramMember rpm
				where
			rpm.RebateProgramID = @RebateID and 
			rpm.OrganizationID = mo.OrganizationID
		 )
		 ) and	
		
		(@Status          IS NULL OR cac.Status = @Status ) and	
		(@Radius          IS NULL OR co.Radius >  = @Radius ) and	

		(@Disabled        IS NULL OR cac.Disabled         = @Disabled ) and
		(@KwikComfort     IS NULL OR co.KwikComfort     = @KwikComfort ) and
		(@Nate            IS NULL OR cac.ShowNateLogo = @Nate ) and
		(@ShowOnLocator   IS NULL OR cac.ShowOnLocator    = @ShowOnLocator ) and
		(@FollowUp        IS NULL OR co.followup = @FollowUp ) and
		(@Top1            IS NULL OR cac.TopOne  = @Top1 ) and
		(@Top10           IS NULL OR cac.TopTen  = @Top10 ) and
		(@ProtectionPlus  IS NULL OR cac.ProtectionPlus    = @ProtectionPlus ) and
		(@CashBack        IS NULL OR cac.CashBack      = @CashBack ) and
		(@Mechanical      IS NULL OR cac.Mechanical      = @Mechanical ) and
		(@Commercial      IS NULL OR cac.Commercial      = @Commercial ) and
		(@AirTime500      IS NULL OR cac.AirTime500      = @AirTime500 ) and		
		(@DesignStar      IS NULL OR cac.DesignStar         = @DesignStar) and
		
		(@PersonWebSite      IS NULL OR (co.WebSite not like '%Rheem%' or co.website not like '%ruud%' ) ) and
		(@RheemOrRuudWebsite IS NULL OR (co.WebSite  like '%Rheem%' or co.website  like '%ruud%' ) ) and

		(
		(@Disabled            IS NULL and (cac.Disabled is null or cac.disabled='0')) or 
		(@Disabled            IS NOT NULL and (cac.Disabled =@Disabled))
		) 

		--@ActivationStartDate varchar(50),
		--@ActivationEndDate varchar(50),
		--@TerminationStartDate varchar(50),
		--@TerminationEndDate varchar(50)
			
	  order by o.OrganizationName

END
GO
