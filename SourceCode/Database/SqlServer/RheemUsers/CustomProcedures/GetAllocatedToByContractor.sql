USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAllocatedToByContractor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAllocatedToByContractor]
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
CREATE PROCEDURE [dbo].[GetAllocatedToByContractor] 
	-- Add the parameters for the stored procedure here
	@DistributorValue uniqueidentifier,
	@SingleOrgID bit
AS
BEGIN
DECLARE @sql nvarchar(MAX),
        @paramlist  nvarchar(4000)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
    SELECT @sql = 'SELECT o.* 
	               FROM  rheemusers..organization o, rheemusers..contractorOrganization co,  
                         rheemusers..contractorAC cac,rheemusers..OrganizationBrand ob, rheemdb..Brand b 
				   WHERE '
	IF @SingleOrgID = 1
	  BEGIN
        SELECT @sql = @sql + ' cac.DistributorOrganizationID = @DistributorValue '
	  END
    ELSE
	  BEGIN
          SELECT @sql = @sql + ' cac.DistributorOrganizationID in ( 
		                           SELECT distinct o.organizationid 
		                           FROM rheemusers..organization o, rheemusers..organizationparent op 
                                   WHERE o.OrganizationID         = op.Organizationid and 
                                         (o.organizationid        = @DistributorValue or 
                                          op.ParentOrganizationId = @DistributorValue ) and 
                                          o.OrganizationType=''Distributor'') '
	  END

     SELECT @sql = @sql + ' and cac.OrganizationID = o.OrganizationId and 
                            cac.OrganizationId = co.OrganizationId and  
                            o.OrganizationType = ''Dealer'' and 
                            o.OrganizationId   = ob.OrganizationId and  
                            ob.BrandID         = b.brandid and  
                            b.BrandName in (''RheemTeam'', ''Ruud Reliable'') and  
                            (co.disabled is null or co.disabled = ''0'') and  
                            (cac.disabled is null or cac.disabled = ''0'') 
                           ORDER BY OrganizationName'


	 SELECT @paramlist = '@distributorValue  uniqueidentifier, 
						  @singleOrgID       varchar(50)' 

     EXEC sp_executesql @sql, @paramlist, @DistributorValue, @SingleOrgID

END
GO
