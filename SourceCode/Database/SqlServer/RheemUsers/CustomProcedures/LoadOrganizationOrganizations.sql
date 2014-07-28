USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadOrganizationOrganizations]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[LoadOrganizationOrganizations]
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
CREATE PROCEDURE [dbo].[LoadOrganizationOrganizations]

@OrganizationID uniqueidentifier

AS 


DECLARE @treeUpdated datetime
SET @treeUpdated = (SELECT treeUpdated FROM rheemusers..Organization WHERE OrganizationID=@OrganizationID)
DECLARE @orgParentUpdated datetime
SET @orgParentUpdated = (SELECT Timestamp FROM rheemdb..env WHERE envName='OrganizationParentUpdated')

--IF @treeUpdated IS NULL OR @orgParentUpdated > @treeUpdated
IF 2>1
	BEGIN
	   CREATE TABLE #sp_loadOrgOrgs (
        	[OrganizationIDChild] [uniqueidentifier] NOT NULL,
	     	[OrganizationIDNode] [uniqueidentifier] NOT NULL,
            PRIMARY KEY (OrganizationIDNode, OrganizationIDChild)
	   )
	    --Get only currently active orgs that a person is a member of
	    INSERT INTO #sp_loadOrgOrgs 
	         SELECT  distinct( OrganizationID ), @OrganizationID  from RheemUsers..OrganizationParent
					WHERE 
				ParentOrganizationID = @OrganizationID 

		DECLARE @thisVal int
		SET @thisVal = (SELECT COUNT(1) AS cnt FROM #sp_loadOrgOrgs WHERE OrganizationIDNode=@OrganizationID)
		DECLARE @lastVal int
		SET @lastVal = 0

		WHILE @thisVal > @lastVal
		BEGIN
		  SET @lastVal = @thisVal
            -- This Gets the parent organizations of all the organizations already
			--   in #sp_loadOrgOrgs, unless that parent is there already.  It will stop
			--    walking up the tree when no new rows get added.
		  INSERT INTO #sp_loadOrgOrgs 
			SELECT DISTINCT(op.OrganizationID), @OrganizationID  FROM 
			RheemUsers..OrganizationParent op
			INNER JOIN #sp_loadOrgOrgs spo ON op.ParentOrganizationID = spo.OrganizationIDChild  
			  WHERE 
		      (0=(SELECT COUNT(1) FROM #sp_loadOrgOrgs WHERE OrganizationIDNode=@OrganizationID AND
		            op.OrganizationID = OrganizationIDChild
				))

		  SET @thisVal = (SELECT COUNT(*) AS cnt FROM #sp_loadOrgOrgs WHERE OrganizationIDNode=@OrganizationID)
		END
		
		-- Delete any orgs in MyOrganizations not in the temp table
		DELETE FROM MyOrganizationOrganizations 
			WHERE 
		OrganizationIDNode = @OrganizationID and
		OrganizationIDChild NOT IN (
			SELECT so.OrganizationIDChild FROM #sp_loadOrgOrgs so 
				WHERE 
			so.OrganizationIDNode=@OrganizationID
			)
			
		-- Add any orgs in temp table not in MyOrganizations
		INSERT INTO  MyOrganizationOrganizations ( MyOrganizationOrganizationsID, OrganizationIDNode, OrganizationIDChild) (
		  SELECT newid(), OrganizationIDNode, OrganizationIDChild FROM #sp_loadOrgOrgs 
				WHERE 
			OrganizationIDNode = @OrganizationID AND
		    OrganizationIDChild NOT IN (
				SELECT OrganizationIDChild FROM MyOrganizationOrganizations WHERE OrganizationIDNode=@OrganizationID)
				)
						    
		DROP TABLE #sp_loadOrgOrgs		
			
		UPDATE rheemusers..Organization SET treeUpdated=getdate() WHERE OrganizationID=@OrganizationID

	END 

GO

