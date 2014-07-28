USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBuilders]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBuilders]
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
CREATE PROCEDURE [dbo].[GetBuilders] 
	-- Add the parameters for the stored procedure here
	@searchParam varchar(4000),
	@userID varchar(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = 'SELECT bo.OrganizationID, bo.BuilderID, b.BGSPersonID, 
      a.AddressLine1, a.AddressLine2, a.City, a.State, a.PostalCode, 
      o.OrganizationName, op.ParentOrganizationID, op.OrganizationParentID
    FROM rheemusers..BuilderOrganization bo 
     INNER JOIN rheemusers..MyOrganizations mo 
       ON mo.OrganizationID = bo.OrganizationID and mo.PersonID='''+ @userID + '''
     INNER JOIN rheemusers..Organization o ON bo.OrganizationID = o.OrganizationID 
     INNER JOIN builder..Builder b 
         ON bo.BuilderID = b.BuilderID and b.Status <> ''Disabled''
     INNER JOIN RheemUsers..OrganizationParent op 
         ON bo.OrganizationID = op.OrganizationID and op.Relationship = ''BuilderOfRegion'' 
     LEFT OUTER JOIN rheemusers..Address a ON bo.PrimaryAddressID = a.AddressID 
    WHERE ' + @searchParam + ' ORDER BY o.OrganizationName'

	EXEC(@strSql)

END
GO
