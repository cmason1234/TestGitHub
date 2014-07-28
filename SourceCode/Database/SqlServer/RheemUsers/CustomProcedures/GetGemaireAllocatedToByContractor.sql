USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetGemaireAllocatedToByContractor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetGemaireAllocatedToByContractor]
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
CREATE PROCEDURE [dbo].[GetGemaireAllocatedToByContractor] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
    SELECT o.* 
	   FROM  organization o
	   inner Join MyOrganizations mo on o.OrganizationID=mo.OrganizationID and mo.PersonID = @PersonID
       Inner Join contractorAC cac on cac.OrganizationID = o.OrganizationId and (cac.disabled is null or cac.disabled = '0') 
	   inner Join rheemdb..Brand b on cac.BrandID = b.brandid 
	WHERE 
		    o.OrganizationType in ('Dealer', 'Contractor') and 
			b.BrandName in ('RheemTeam', 'Ruud Reliable')
     ORDER BY OrganizationName

END
GO
