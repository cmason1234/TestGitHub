USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadMyOrganizations]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[LoadMyOrganizations]
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
CREATE PROCEDURE [dbo].[LoadMyOrganizations]

@PersID uniqueidentifier

AS 


DECLARE @treeUpdated datetime
SET @treeUpdated = (SELECT treeUpdated FROM rheemusers..Person WHERE personid=@PersID)
DECLARE @orgParentUpdated datetime
SET @orgParentUpdated = (SELECT Timestamp FROM rheemdb..env WHERE envName='OrganizationParentUpdated')

IF @treeUpdated IS NULL OR @orgParentUpdated > @treeUpdated
	BEGIN
	   CREATE TABLE #sp_loadMyOrgs (
	     	[OrganizationID] [uniqueidentifier] NOT NULL,
        	[PersonID] [uniqueidentifier] NOT NULL,
            PRIMARY KEY (PersonID, OrganizationID)
	   )
	    --Get only currently active orgs that a person is a member of
	    INSERT INTO #sp_loadMyOrgs 
	         SELECT OrganizationID, @PersID   
	           FROM RheemUsers..Organization 
	            WHERE OrganizationID in (
	             SELECT OrganizationID 
	               FROM RheemUsers..PersonOrganization 
	               WHERE PersonID = @PersID)

		DECLARE @thisVal int
		SET @thisVal = (SELECT COUNT(1) AS cnt FROM #sp_loadMyOrgs WHERE PersonID=@PersID)
		DECLARE @lastVal int
		SET @lastVal = 0

		WHILE @thisVal > @lastVal
		BEGIN
		  SET @lastVal = @thisVal
            -- This Gets the parent organizations of all the organizations already
			--   in #sp_loadMyOrgs, unless that parent is there already.  It will stop
			--    walking up the tree when no new rows get added.
		  INSERT INTO #sp_loadMyOrgs 
			SELECT DISTINCT(o.OrganizationID), @PersID  FROM 
			RheemUsers..Organization o
			INNER JOIN RheemUsers..OrganizationParent op ON o.OrganizationID = op.OrganizationID
			INNER JOIN #sp_loadMyOrgs spo ON op.ParentOrganizationID = spo.OrganizationID AND 
		                                                  spo.PersonID            = @PersID
			  WHERE 
		      (0=(SELECT COUNT(1) FROM #sp_loadMyOrgs WHERE personid=@PersID AND
		            o.OrganizationID = OrganizationID))

		  SET @thisVal = (SELECT COUNT(*) AS cnt FROM #sp_loadMyOrgs WHERE PersonID=@PersID)
		END
		
		-- Delete any orgs in MyOrganizations not in the temp table
		DELETE FROM MyOrganizations WHERE PersonID = @PersID and
		   OrganizationID NOT IN (SELECT so.OrganizationID FROM #sp_loadMyOrgs so WHERE so.PersonID=@PersID)
		-- Add any orgs in temp table not in MyOrganizations
		INSERT INTO MyOrganizations (OrganizationID, PersonID) 
		  (SELECT OrganizationID, PersonID FROM #sp_loadMyOrgs WHERE PersonID = @PersID AND
		    OrganizationID NOT IN (SELECT OrganizationID FROM MyOrganizations WHERE PersonID=@PersID))
		    
		DROP TABLE #sp_loadMyOrgs
		
		Delete from MyOrganizationParents where PersonID=@PersID
		
		With Parents (OrganizationID) as
			(
			  --Anchor
			  SELECT OrganizationID 
						   FROM RheemUsers..PersonOrganization 
						   WHERE PersonID = @PersID
			   UNION ALL
			   -- Recursive member definition - Ignore HD, they are a different model
				 SELECT op.ParentOrganizationID from OrganizationParent OP 
					INNER JOIN Parents p on op.OrganizationID=p.OrganizationID
                                 where op.Relationship <> 'DealerOfHDStore'


			)
			INSERT INTO MyOrganizationParents (OrganizationID, PersonID)
				Select DISTINCT OrganizationID, @PersID as PersonID from Parents
		option (maxrecursion 250);
		
		UPDATE rheemusers..Person SET treeUpdated=getdate() WHERE personid=@PersID

	END 

GO

GRANT execute ON OBJECT::dbo.LoadMyOrganizations TO whuser;
go
GRANT EXECUTE ON OBJECT::dbo.LoadMyOrganizations TO rheemparts;  
