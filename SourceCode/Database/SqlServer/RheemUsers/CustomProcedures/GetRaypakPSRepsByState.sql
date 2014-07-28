USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRaypakPSRepsByState]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRaypakPSRepsByState]
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
CREATE PROCEDURE [dbo].[GetRaypakPSRepsByState] 
	-- Add the parameters for the stored procedure here
	@State varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select Oterritory.OrganizationName as Territory, 
	p.FirstName, p.LastName, p.Phone , p.EmailAddress,
	pOrg.OrganizationName, pAdd.AddressLine1, pAdd.AddressLine2, 
	pAdd.City, pAdd.State, pAdd.PostalCode, p.Signature
	  from rheemusers..Organization Oterritory
	  Inner JOIN rheemusers..OrganizationParent OP on 
		 Oterritory.OrganizationID=OP.OrganizationID and 
		 OP.ParentOrganizationID in (
			select OrganizationID from rheemusers..organization oReg
			   where
			organizationtype='PS Region' and
			organizationname =@State
		 )
	  Inner join RheemUsers..PersonOrganization po on 
		 Oterritory.OrganizationID = po.OrganizationID 
	  Inner join RheemUsers..Person p on 
		 po.personID = p.personID      
	 Inner join RheemUsers..organization pOrg on 
		 p.PrimaryOrganizationID  = pOrg.OrganizationID      
	 Inner join RheemUsers..Address pAdd on 
		 p.PrimaryAddressID   = pAdd.AddressID       

END
GO
