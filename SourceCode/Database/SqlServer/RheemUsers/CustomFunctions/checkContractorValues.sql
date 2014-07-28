USE [RheemUsers]
GO
 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[checkContractorValues]') AND type in (N'FN'))
DROP FUNCTION [dbo].[checkContractorValues]
GO

/****** Object:  UserDefinedFunction [dbo].[checkContractorValues]    Script Date: 07/01/2014 17:43:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


-- =============================================
-- Author:		Neal
-- Create date: Sept. 7, 2010
-- Description:	Checks If Contractor is AC
-- =============================================
CREATE FUNCTION [dbo].[checkContractorValues]
(	
	@orgID as uniqueidentifier,
	@type as varchar(15)
)

RETURNS int --was bit
AS
BEGIN
		DECLARE @returnBit as int --was as bit
	SET @returnBit = 0
	
	--if @type = 'AC'
	--set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID)
	
	--if @type = 'WHInstall'
	--set @returnBit = (select Installer from dbo.ContractorWaterHeater where OrganizationID = @orgID)

	--else if @type = 'WHRepair'
	--set @returnBit = (select Repair from dbo.ContractorWaterHeater where OrganizationID = @orgID)	
	
	--select * from ContractorAC where organizationid = 'DF8FCEBF-DE90-48E1-9924-6DF03363E6E2'


	-- adding this because somehow the contractor page is so complicated it showing dealers who are not set as show on locator even though every one of these has it included
	
	if @type = 'WHCom'
	set @returnBit = (select Commercial from dbo.ContractorWaterHeater where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1 )	


	else if @type = 'WHRes'
	set @returnBit = (select residential from dbo.ContractorWaterHeater where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1)


	else if @type = 'ASP'
	set @returnBit = (select ServiceContractor from dbo.ContractorWaterHeater where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1)

    else if @type = 'WHInstall'
	set @returnBit = (select Installer from dbo.ContractorWaterHeater where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1)	

	else if @type = 'WHTankless'
	set @returnBit = (select Tankless from dbo.ContractorWaterHeater where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1)	

	else if @type = 'WHSolar'
	set @returnBit = (select ServiceSolar from dbo.ContractorWaterHeater where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1)	


else if @type = 'HomeDepot'
	set @returnBit = (select count(OrganizationID) from
rheemusers..ContractorRetail 
		where OrganizationID = @orgID AND 
		HomeDepot = 1 and
            HDShowOnLocator=1 and Disabled != 1)


	else if @type = 'AC'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1)	

	else if @type = 'PS'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorPoolSpa where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1)

	else if @type = 'GEN'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorGenerator where OrganizationID = @orgID and ShowOnLocator = 1 and Disabled != 1)
	
	else if @type = 'GENRheem'
	--set @returnBit = (select count(OrganizationID) from dbo.ContractorGenerator where OrganizationID = @orgID AND BrandID = '3469e15a-b68d-4d4c-92ab-c372f1a6688b' and ShowOnLocator = 1 and Disabled != 1)
set @returnBit = (select count(cg.OrganizationID) from rheemusers..ContractorGenerator cg inner join rheemusers..ContractorGeneratorBrands cgb on cgb.OrganizationID = cg.OrganizationID where cg.OrganizationID = @orgID AND cgb.BrandID = '3469e15a-b68d-4d4c-92ab-c372f1a6688b' and cg.ShowOnLocator = 1 and cg.Disabled != 1)	

	else if @type = 'GENRuud'
	--set @returnBit = (select count(OrganizationID) from dbo.ContractorGenerator where OrganizationID = OrganizationID and OrganizationID = @orgID AND BrandID = 'B91B7302-2342-4B80-B14A-DD7BC9CAE8E7' and ShowOnLocator = 1 and Disabled != 1)
set @returnBit = (select count(cg.OrganizationID) from rheemusers..ContractorGenerator cg inner join rheemusers..ContractorGeneratorBrands cgb on cgb.OrganizationID = cg.OrganizationID where cg.OrganizationID = @orgID AND cgb.BrandID = 'B91B7302-2342-4B80-B14A-DD7BC9CAE8E7' and cg.ShowOnLocator = 1 and cg.Disabled != 1)		

	else if @type = 'WHPlace'
	set @returnBit = (select LocatorPlacement from dbo.ContractorWaterHeater where OrganizationID = @orgID)	

	else if @type = 'ACPlace'
	--if @orgID = '5BE68CBE-577C-4C7D-B633-80FB20B52D1A'
	set @returnBit = (select LocatorPlacement from dbo.ContractorAC where OrganizationID = @orgID)									
	

	else if @type = 'ACRheem'
	set @returnBit =(select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID AND BrandID = '3469e15a-b68d-4d4c-92ab-c372f1a6688b' and ShowOnLocator = 1 and (Disabled != 1 or disabled is null))									

	else if @type = 'ACRuud'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID AND BrandID = 'B91B7302-2342-4B80-B14A-DD7BC9CAE8E7' and ShowOnLocator = 1 and (Disabled != 1 or disabled is null))									

	else if @type = 'ACRheemTeam'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID AND BrandID = 'CD6dd81a-1a25-4400-bf6a-11a5a1cf6c20'  and ShowOnLocator = 1 and (Disabled != 1 or disabled is null))								


	else if @type = 'ACRuudReliable'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID AND BrandID = '87a2902b-737a-469c-bb64-b8d05b4284a3'  and ShowOnLocator = 1 and (Disabled != 1 or disabled is null))									

	else if @type = 'WHRuud'
	set @returnBit = (select count(Ruud) from dbo.ContractorWaterHeater where OrganizationID = @orgID AND Ruud = 1  and ShowOnLocator = 1 and (Disabled != 1 or disabled is null))	
								
		

	else if @type = 'WHRheem'
	set @returnBit = (select count(Rheem) from dbo.ContractorWaterHeater where OrganizationID = @orgID AND Rheem = 1  and ShowOnLocator = 1 and (Disabled != 1 or disabled is null))								

	else if @type = 'WHRichmond'
	set @returnBit = (select count(Richmond) from dbo.ContractorWaterHeater where OrganizationID = @orgID AND Richmond = 1  and ShowOnLocator = 1 and (Disabled != 1 or disabled is null))
	
	else if @type = 'TopTen'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID AND TopTen = 1)

	else if @type = 'DesignStar'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID AND DesignStar = 1 and DesignStarActive = 1)
	else if @type = 'KwikComfort'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorOrganization where OrganizationID = @orgID AND KwikComfort = 1)
	else if @type = 'PPlus'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID AND ProtectionPlus = 1)
	else if @type = 'Cashback'
	set @returnBit = (select count(RebateProgramMember.OrganizationID) from RebateProgram INNER JOIN
                      RebateProgramMember ON RebateProgram.RebateProgramID = RebateProgramMember.RebateProgramID
		where RebateProgramMember.OrganizationID =  @orgID AND 
		--(RebateProgram.ProgramName = '2014 Spring Consumer CashBack Rebate Program') AND (RebateProgram.ProgramYear = '2014'))	
	(RebateProgram.ProgramName = '2020 Spring Consumer CashBack Rebate Program') AND (RebateProgram.ProgramYear = '2020'))		
	else if @type = 'ShowNateLogo'
	set @returnBit = (select count(OrganizationID) from dbo.ContractorAC where OrganizationID = @orgID AND ShowNateLogo = 1)

	RETURN isNull(@returnBit, 0)
END



GO


