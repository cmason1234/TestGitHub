USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRaypakWSPContractorsByCityState]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRaypakWSPContractorsByCityState]
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
CREATE PROCEDURE [dbo].[GetRaypakWSPContractorsByCityState] 
	-- Add the parameters for the stored procedure here
	@City varchar(50),
	@State varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select co.PrimaryAddressID paid, * from rheemusers..Organization o, rheemusers..ContractorOrganization co, 
	rheemusers..ContractorPoolSpa csp, rheemusers..Address a  
	   where 
	o.OrganizationID = co.OrganizationID and 
	o.OrganizationID = csp.OrganizationID and 
	(csp.disabled is null or csp.disabled = '0') and 
	csp.WarrantyServiceProvider=1 and 
	co.PrimaryAddressID = a.AddressID  and 
	a.city like @city and 
	a.state like @state
		order by o.organizationName 

END
GO
