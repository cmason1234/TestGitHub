USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuPrivsNew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetMenuPrivsNew]
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
CREATE PROCEDURE [dbo].[GetMenuPrivsNew] 
AS
BEGIN

	SELECT mar.MenuID, a.ApplicationName + '-' + r.RoleName ARName, mar.ApplicationRoleID 
	 FROM MenuApplicationRole mar
	 INNER JOIN ApplicationRole ar ON mar.ApplicationRoleID = ar.ApplicationRoleID
	 INNER JOIN Application a ON ar.ApplicationID = a.ApplicationID
	 INNER JOIN Role r ON ar.RoleID = r.RoleID
	 ORDER BY mar.MenuID, a.ApplicationName, r.RoleName

 
    SELECT mot.MenuID, mot.OrganizationTypeID, ot.OrganizationType FROM MenuOrganizationType mot 
	 INNER JOIN OrganizationType ot ON mot.OrganizationTypeID=ot.OrganizationTypeID
    ORDER BY mot.MenuID, OrganizationType

    SELECT mb.MenuID, mb.BrandID, b.BrandName FROM MenuBrand mb
	  INNER JOIN RheemDB..Brand b on mb.BrandID = b.BrandID
	 ORDER BY mb.MenuID, BrandName
	 
   SELECT mws.MenuID, mws.RheemWebSiteID, WebSiteName, WebSiteURL from MenuWebSite mws
      INNER JOIN RheemWebSite rws ON mws.RheemWebSiteID=rws.RheemWebSiteID
   ORDER BY mws.MenuID, WebSiteName

END
GO
