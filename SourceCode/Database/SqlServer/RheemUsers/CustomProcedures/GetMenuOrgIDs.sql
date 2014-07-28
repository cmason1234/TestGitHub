USE [rheemusers]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuOrgTypes]') AND type in (N'P', N'PC'))
DROP procedure [dbo].[GetMenuOrgTypes]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE procedure [dbo].[GetMenuOrgTypes] 
(
	-- Add the parameters for the function here
	@MenuID uniqueidentifier
)

AS
BEGIN
	SELECT ot.OrganizationType FROM MenuOrganizationType mot 
	 INNER JOIN OrganizationType ot ON mot.OrganizationTypeID=ot.OrganizationTypeID
	WHERE mot.MenuID =@MenuID

END


GO


