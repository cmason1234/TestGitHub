USE rheem;

DROP PROCEDURE IF Exists LoadMyOrganizations;

DELIMITER $$
CREATE PROCEDURE LoadMyOrganizations (
     in p_PersonID varchar(64)
  )
BEGIN

	DECLARE treeUpdated datetime;
	DECLARE orgParentUpdated datetime;

	SELECT mysqlTreeUpdated FROM ru_person WHERE personid=p_PersonID INTO treeUpdated;

	SELECT Timestamp FROM rdb_env WHERE envName='OrganizationParentUpdated' INTO orgParentUpdated;

	IF treeUpdated IS NULL OR orgParentUpdated > treeUpdated THEN
		DROP TEMPORARY TABLE IF EXISTS myorgs;
	    CREATE TEMPORARY TABLE IF NOT EXISTS myorgs (
			OrganizationID varchar(64),
            INDEX myorgs_1 using hash (OrganizationID)
    	);
		DROP TEMPORARY TABLE IF EXISTS myorgs1;
	    CREATE TEMPORARY TABLE IF NOT EXISTS myorgs1 (
			OrganizationID varchar(64),
            INDEX myorgs_2 using hash (OrganizationID)
    	);
		DROP TEMPORARY TABLE IF EXISTS myorgs2;
	    CREATE TEMPORARY TABLE IF NOT EXISTS myorgs2 (
			OrganizationID varchar(64),
            INDEX myorgs_3 using hash (OrganizationID)
    	);

		-- Get only currently active orgs that a person is a member of
		INSERT INTO myorgs (OrganizationID) 
			 SELECT po.OrganizationID  
			   FROM ru_personorganization po
				WHERE PersonID = p_PersonID;

		SELECT COUNT(1) FROM myorgs INTO @thisVal;
		SET @lastVal = 0;

		WHILE @thisVal > @lastVal DO
		  SET @lastVal = @thisVal;
		  TRUNCATE TABLE myorgs1;
		  INSERT INTO myorgs1 (OrganizationID) SELECT OrganizationID from myorgs;
		  TRUNCATE TABLE myorgs2;
		  INSERT INTO myorgs2 (OrganizationID) SELECT OrganizationID from myorgs;

		  INSERT INTO myorgs (OrganizationID)
			select distinct(op.OrganizationID) from myorgs1 m1 
				inner join ru_organizationparent op on op.ParentOrganizationID=m1.OrganizationID AND 
							 (0=( select count(*) from myorgs2 where op.OrganizationID = OrganizationID));
							 
		  SELECT COUNT(*) AS cnt FROM myorgs INTO @thisVal;
		END WHILE;
		
		-- Delete any orgs in MyOrganizations not in the temp table
		DELETE FROM ru_myorganizations WHERE PersonID = p_PersonID and
		   OrganizationID NOT IN (SELECT m1.OrganizationID FROM myorgs m1);
		-- Add any orgs in temp table not in MyOrganizations
		INSERT INTO ru_myorganizations (OrganizationID, PersonID) 
		  (SELECT OrganizationID, p_PersonID FROM myorgs WHERE 
			   OrganizationID NOT IN (SELECT OrganizationID FROM ru_myorganizations WHERE PersonID=p_PersonID));

		-- The code beneath here, loads up the parent orgs of this person, this is currently not
		-- used in the MySql World, it may be revisited at a later date.
        -- Delete from sp_loadmyorgsparents where PersonID=p_PersonID;
		-- Get only currently active orgs that a person is a member of
		-- INSERT INTO sp_loadmyorgsparents (OrganizationID, PersonID) 
		-- 	 SELECT po.OrganizationID, po.PersonID   
		-- 	   FROM ru_personorganization po
		-- 		 INNER JOIN ru_organization o on po.OrganizationID=o.OrganizationID
		-- 		WHERE PersonID = p_PersonID;

		-- SELECT COUNT(1) FROM sp_loadmyorgsparents WHERE PersonID=p_PersonID INTO @thisVal;
		-- SET @lastVal = 0;

		-- WHILE @thisVal > @lastVal DO
		--   SET @lastVal = @thisVal;
			-- This Gets the parent organizations of all the organizations already
			--   in sp_loadmyorgs, unless that parent is there already.  It will stop
			--    walking up the tree when no new rows get added.
		-- 	INSERT INTO sp_loadmyorgsparents 
		-- 		SELECT DISTINCT(o.OrganizationID), p_PersonID  FROM 
		-- 		ru_organization o
		-- 		INNER JOIN ru_organizationparent op ON o.OrganizationID = op.ParentOrganizationID
		-- 		INNER JOIN sp_loadmyorgsparents spo ON op.OrganizationID = spo.OrganizationID AND 
		-- 									spo.PersonID =	p_PersonID
		-- 		  WHERE 
		-- 		  (0=(SELECT COUNT(1) FROM sp_loadmyorgsparents WHERE personid=p_PersonID AND
		-- 				o.OrganizationID = OrganizationID));

		--   SELECT COUNT(*) AS cnt FROM sp_loadmyorgsparents WHERE PersonID=p_PersonID INTO @thisVal;
		-- END WHILE;

		-- Delete any orgs in MyOrganizationsParents not in the temp table
		-- DELETE FROM ru_myorganizationparents WHERE PersonID = p_PersonID and
		--    OrganizationID NOT IN (SELECT so.OrganizationID FROM sp_loadmyorgsparents so WHERE so.PersonID=p_PersonID);
		-- Add any orgs in temp table not in MyOrganizations
		-- INSERT INTO ru_myorganizationparents (OrganizationID, PersonID) 
		--   (SELECT OrganizationID, PersonID FROM sp_loadmyorgsparents WHERE PersonID = p_PersonID AND
		-- 	OrganizationID NOT IN (SELECT OrganizationID FROM ru_myorganizationparents WHERE PersonID=p_PersonID));

        -- Delete from sp_loadmyorgsparents where PersonID=p_PersonID;

        UPDATE ru_person SET mysqlTreeUpdated=NOW() where PersonID=p_PersonID;
	END IF;

END$$
DELIMITER ;


