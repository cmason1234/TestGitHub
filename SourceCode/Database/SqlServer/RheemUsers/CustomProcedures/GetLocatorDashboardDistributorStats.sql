USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLocatorDashboardDistributorStats]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetLocatorDashboardDistributorStats]
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
CREATE PROCEDURE [dbo].[GetLocatorDashboardDistributorStats]
    -- Add the parameters for the stored procedure here
    
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorLocatorProcess dlp
			INNER JOIN rheemusers..DistributorOrganization do ON do.OrganizationID=dlp.OrganizationID and
				(do.Corporate IS NULL OR do.Corporate=0)    
		WHERE dlp.EndDate - GETDATE() < 30) As corp30Days,
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorLocatorProcess dlp
			INNER JOIN rheemusers..DistributorOrganization do ON do.OrganizationID=dlp.OrganizationID and
				do.Corporate = 1    
		WHERE dlp.EndDate - GETDATE() < 30) As branches30Days,
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorLocatorProcess dlp
			INNER JOIN rheemusers..DistributorOrganization do ON do.OrganizationID=dlp.OrganizationID and
				(do.Corporate IS NULL OR do.Corporate=0)    
		WHERE dlp.EndDate - GETDATE() < 60 and EndDate - GETDATE() >= 30) As corp60Days,
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorLocatorProcess dlp
			INNER JOIN rheemusers..DistributorOrganization do ON do.OrganizationID=dlp.OrganizationID and
				do.Corporate = 1    
		WHERE dlp.EndDate - GETDATE() < 60 and EndDate - GETDATE() >= 30) As branches60Days,
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorLocatorProcess dlp
			INNER JOIN rheemusers..DistributorOrganization do ON do.OrganizationID=dlp.OrganizationID and
				(do.Corporate IS NULL OR do.Corporate=0)    
		WHERE dlp.EndDate - GETDATE() < 90 and EndDate - GETDATE() >= 60) As corp90Days,
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorLocatorProcess dlp
			INNER JOIN rheemusers..DistributorOrganization do ON do.OrganizationID=dlp.OrganizationID and
				do.Corporate = 1    
		WHERE dlp.EndDate - GETDATE() < 90 and EndDate - GETDATE() >= 60) As branches90Days,
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorLocatorProcess dlp
			INNER JOIN rheemusers..DistributorOrganization do ON do.OrganizationID=dlp.OrganizationID and
				do.Corporate = 1 and (do.Disabled IS NULL OR do.Disabled = 0)) As corpEnrolled,
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorLocatorProcess dlp
			INNER JOIN rheemusers..DistributorOrganization do ON do.OrganizationID=dlp.OrganizationID and
				(do.Corporate IS NULL OR do.Corporate = 0) and (do.Disabled IS NULL OR do.Disabled = 0)) As branchesEnrolled,
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorOrganization do 
		WHERE do.Corporate = 1 and (do.Disabled IS NULL OR do.Disabled = 0)) As corpTotalDistributors,	
		(SELECT COUNT(*) 
		FROM rheemusers..DistributorOrganization do 
		WHERE (do.Corporate IS NULL OR do.Corporate = 0) and (do.Disabled IS NULL OR do.Disabled = 0)) As branchesTotalDistributors

END
GO
