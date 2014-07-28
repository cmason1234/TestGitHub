USE ahridata;

DROP PROCEDURE IF Exists GetAHRIACData;

DELIMITER $$
CREATE PROCEDURE GetAHRIACData(
	p_Skip int,
	p_Top int,
	p_WhereClause varchar(4000)
)
BEGIN
	set @s = concat('SELECT (SELECT count(*) from ahriacdata acd WHERE ', p_WhereClause, 
              ') as TotalRows, AHRIReferenceNumber, OutdoorUnitModel, IndoorUnitModel, FurnaceModel from ahriacdata acd WHERE ', 
	                        p_WhereClause, ' order by OutdoorUnitModel, IndoorUnitModel, FurnaceModel, AHRIReferenceNumber LIMIT ', 
							p_Skip, ', ', p_Top);
	
	PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$
DELIMITER ;

