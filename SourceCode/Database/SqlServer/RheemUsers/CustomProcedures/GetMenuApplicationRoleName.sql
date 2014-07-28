USE [rheemusers]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuApplicationRoleName]') AND type in (N'P', N'PC'))
DROP procedure [dbo].[GetMenuApplicationRoleName]
GO


/****** Object:  UserDefinedFunction [dbo].[GetApplicationRoleID]    Script Date: 05/17/2012 12:59:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE procedure [dbo].[GetMenuApplicationRoleName] 
(
	-- Add the parameters for the function here
	@MenuID uniqueidentifier
)

AS
BEGIN
	select a.ApplicationName + '-' + r.RoleName ARName from rheemusers..Menu m, rheemusers ..MenuApplicationRole mar, 
	rheemusers..Application a, rheemusers..ApplicationRole ar, rheemusers ..Role r
	   where
	m.MenuID =@MenuID and 
	m.MenuID = mar.MenuID  and 
	mar.ApplicationRoleID = ar.ApplicationRoleID and 	
	ar.ApplicationID = a.ApplicationID and 
	ar.RoleID = r.RoleID order by a.ApplicationName, r.RoleName

END


GO


