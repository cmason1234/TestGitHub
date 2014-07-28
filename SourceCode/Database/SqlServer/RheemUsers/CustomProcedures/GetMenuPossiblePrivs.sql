USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuPossiblePrivs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetMenuPossiblePrivs]
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
CREATE PROCEDURE [dbo].[GetMenuPossiblePrivs] 
	-- Add the parameters for the stored procedure here
	@MenuID uniqueidentifier
AS
BEGIN

SELECT MenuID, MenuType, Label, URL, Target, MenuOrder, ParentID from Menu where MenuID=@MenuID

select ApplicationName from Application order by ApplicationName

select ar.ApplicationRoleID, ApplicationName, RoleName, MAR.MenuID from ApplicationRole ar
 inner join Application a on a.ApplicationID=ar.ApplicationID
 inner join Role r on ar.RoleID = r.RoleID
 LEFT OUTER JOIN MenuApplicationRole MAR on ar.ApplicationRoleID=MAR.ApplicationRoleID and
    MAR.MenuID=@MenuID
 order by ApplicationName, RoleName
 
select ot.OrganizationTypeID, ot.OrganizationType, Mot.MenuID from OrganizationType ot
  Left Outer Join MenuOrganizationType Mot on ot.OrganizationTypeID=mot.OrganizationTypeID
  and Mot.MenuID=@MenuID
order by OrganizationType

select b.BrandID, b.BrandName, MB.MenuID from RheemDB..Brand b
  Left Outer Join RheemUsers..MenuBrand MB on b.BrandID=MB.BrandID and
     MB.MenuID=@MenuID
     Order by b.BrandName
	 
select rws.RheemWebSiteID, rws.WebSiteName, mws.MenuID from RheemWebSite rws
  LEFT OUTER JOIN MenuWebSite mws on rws.RheemWebSiteID=mws.RheemWebSiteID and
    mws.MenuID=@MenuID

END
GO
