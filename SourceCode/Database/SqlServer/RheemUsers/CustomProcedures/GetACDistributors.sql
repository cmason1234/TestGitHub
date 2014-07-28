USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetACDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetACDistributors]
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
CREATE PROCEDURE [dbo].[GetACDistributors] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueIdentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select o.OrganizationID, o.OrganizationName, DistributorNumber 
	  from rheemusers..MyOrganizations mo 
	    inner join rheemusers..organization o on mo.OrganizationID = o.OrganizationId and 
  		      o.OrganizationType  = 'Distributor' 
  	    inner join rheemusers..DistributorOrganization do on o.OrganizationID = do.OrganizationId 
	  where mo.personID         = @PersonID and 
 	    (do.Disabled='0' or do.Disabled is null)    and 
		do.ac='1'  and 
		(do.PoolSpaDisabled is null or do.PoolSpaDisabled ='0')  and 
		(do.PartsDisabled is null or do.PartsDisabled='0')     
	  order by o.OrganizationName

END
GO
