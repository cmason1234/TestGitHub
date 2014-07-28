USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAdminFind]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAdminFind]
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
CREATE PROCEDURE [dbo].[GetAdminFind] 
	-- Add the parameters for the stored procedure here
	@EmailStart varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 SELECT pm.PersonID
    ,FirstName + ' ' + LastName AS FullName 
    ,EmailAddress
    ,pm.Phone
    ,pm.Username
    ,o2.OrganizationName
    ,(
      SELECT COUNT(1) FROM PersonRole pr WHERE pr.PersonID=pm.PersonID
    ) as NumPrivs
  FROM rheemusers..person pm
   LEFT OUTER JOIN rheemusers..organization o2 ON pm.PrimaryOrganizationID = o2.OrganizationID
  WHERE emailaddress LIKE @EmailStart 
  ORDER BY LastName, emailaddress 

END
GO
