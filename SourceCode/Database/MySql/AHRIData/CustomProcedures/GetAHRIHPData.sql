USE ahridata;

DROP PROCEDURE IF Exists GetAHRIHPData;

DELIMITER $$
CREATE PROCEDURE GetAHRIHPData(
	p_Skip int,
	p_Top int,
	p_WhereClause varchar(4000)
)
BEGIN

	set @s = concat('SELECT (SELECT count(*) from ahrihpdata ahd WHERE ', p_WhereClause, 
              ') as TotalRows, AHRIReferenceNumber, OutdoorUnitModel, IndoorUnitModel, FurnaceModel from ahrihpdata ahd WHERE ', p_WhereClause, 
	         ' order by OutdoorUnitModel, IndoorUnitModel, FurnaceModel, AHRIReferenceNumber LIMIT ', p_Skip, ', ', p_Top);
	
	PREPARE stmt2 FROM @s;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;
END$$
DELIMITER ;

