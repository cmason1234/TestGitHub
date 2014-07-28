USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRebateApplicationRoles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRebateApplicationRoles]
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
CREATE PROCEDURE [dbo].[GetRebateApplicationRoles] 
  
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	select ApplicationID, ApplicationName  from RheemUsers..Application 
		where
	ApplicationName in ('CIMS', 'AIMS', 'BHPG2', 'Partners' ) order by ApplicationName
  
	select ar.ApplicationRoleID , a.ApplicationName , r.RoleName, a.ApplicationID from RheemUsers..ApplicationRole ar 
		left outer join RheemUsers..Role r on ar.RoleID = r.roleid
		left outer join RheemUsers..Application a on ar.ApplicationID = a.ApplicationID 
	where
		a.ApplicationID in (
			select ApplicationID from RheemUsers..Application 
				where
			ApplicationName in ('CIMS', 'AIMS', 'BHPG2', 'Partners' ) 
		)
	order by applicationName, rolename 
  


END
GO
