USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAPIAccessKeysAndOwners]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAPIAccessKeysAndOwners]
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
CREATE PROCEDURE [dbo].[GetAPIAccessKeysAndOwners] 
    -- Add the parameters for the stored procedure here
    @keyOwner varchar(200)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	SELECT ak.APIAccessKeyID,ak.AccessKey,ak.KeyType,o.OrganizationName As KeyOwner
	FROM rheemusers..APIAccessKey ak
		INNER JOIN rheemusers..Organization o ON o.OrganizationID=ak.KeyOwner
	WHERE o.OrganizationName like @keyOwner
	
	UNION

	SELECT ak.APIAccessKeyID,ak.AccessKey,ak.KeyType,p.FirstName + ' ' + p.LastName As KeyOwner
	FROM rheemusers..APIAccessKey ak
		INNER JOIN rheemusers..Person p ON p.PersonID=ak.KeyOwner
	WHERE p.LastName like @keyOwner
	ORDER BY KeyOwner

END
GO
