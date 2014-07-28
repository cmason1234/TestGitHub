USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAllMyKeys]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAllMyKeys]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllMyKeys] 
    -- Add the parameters for the stored procedure here
    @personID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	SELECT APIAccessKey.AccessKey, APIAccessKey.Active, Organization.OrganizationName, APIAccessKey.CreateDateTime__Gen, APIAccessKey.APIAccessKeyID
	FROM MyOrganizations INNER JOIN
	APIAccessKey ON MyOrganizations.OrganizationID = APIAccessKey.KeyOwner INNER JOIN
	Organization ON MyOrganizations.OrganizationID = Organization.OrganizationID
	WHERE (MyOrganizations.PersonID = @personID)
	ORDER BY Organization.OrganizationName, APIAccessKey.CreateDateTime__Gen DESC

END
GO
