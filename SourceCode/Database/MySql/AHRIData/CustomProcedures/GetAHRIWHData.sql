USE ahridata;

DROP PROCEDURE IF Exists GetAHRIWHData;

DELIMITER $$
CREATE PROCEDURE GetAHRIWHData(
	p_Skip int,
	p_Top int,
	p_WhereClause varchar(256)
)
BEGIN

	set @s = concat('SELECT (SELECT count(*) from ahriwhdata WHERE ', p_WhereClause, 
              ') as TotalRows, AHRIReferenceNumber, ModelNumber from ahriwhdata WHERE ', p_WhereClause, 
	         ' order by ModelNumber, AHRIReferenceNumber LIMIT ', p_Skip, ', ', p_Top);
	
	PREPARE stmt2 FROM @s;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;
END$$
DELIMITER ;

