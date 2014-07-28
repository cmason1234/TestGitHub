USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsersInMyOrganizationsByLastName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetUsersInMyOrganizationsByLastName]
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
CREATE PROCEDURE [dbo].[GetUsersInMyOrganizationsByLastName]
    -- Add the parameters for the stored procedure here
    @PersonID uniqueidentifier,
	@LastNameStartsWith varchar(50)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.PersonID,p.LastName,p.FirstName,p.EmailAddress,p.Gender
	FROM   rheemusers..person p 
	WHERE  personid in (
			  SELECT p.personID 
			  FROM   rheemusers..myOrganizations mo, 
					 rheemusers..Organization o, 
					 rheemusers..PersonOrganization po, 
					 rheemusers..Person p    
			  WHERE  mo.personid = @PersonID and 
					 mo.OrganizationID = o.OrganizationID and 
					 o.OrganizationID = po.OrganizationID and 
					 po.PersonID = p.PersonID and 
					 p.LastName like @LastNameStartsWith + '%') 
	ORDER BY p.LastName, p.FirstName

END
GO
