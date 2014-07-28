USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTopContractors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTopContractors]
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
CREATE PROCEDURE [dbo].[GetTopContractors] 
	-- Add the parameters for the stored procedure here
	@OrgID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    Select * 
	FROM rheemusers..Organization o, rheemusers..contractorAC cac, rheemdb..brand b 
    WHERE cac.distributorOrganizationID in 
	   (Select organizationid 
	    FROM rheemusers..organization 
        WHERE (organizationid = @OrgID or 
              organizationID in 
		   (Select OrganizationID 
		    FROM rheemusers..OrganizationParent 
            WHERE ParentOrganizationID = @OrgID)) and 
                  OrganizationType='Distributor' ) and 
				  cac.OrganizationID = o.OrganizationID and cac.brandid = b.brandid and 
                  (b.brandname = 'Ruud Reliable' or b.brandname='RheemTeam')

END
GO
