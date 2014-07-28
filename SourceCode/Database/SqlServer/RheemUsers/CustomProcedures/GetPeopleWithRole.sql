USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPeopleWithRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetPeopleWithRole]
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
CREATE PROCEDURE [dbo].[GetPeopleWithRole] 
	-- Add the parameters for the stored procedure here
	@ApplicationRoleId uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT p.PersonID,
		   p.LastName,
		   p.FirstName,
		   p.EmailAddress,
		   o.OrganizationName,
		   pr.ApplicationRoleID
	FROM rheemusers..PersonRole pr , rheemusers..Person p, rheemusers..Organization o    
	WHERE pr.ApplicationRoleId=@ApplicationRoleId and 
		  pr.personID = p.personid and 
		  p.PrimaryOrganizationID = o.OrganizationID    
	ORDER BY p.LastName 

END
GO
