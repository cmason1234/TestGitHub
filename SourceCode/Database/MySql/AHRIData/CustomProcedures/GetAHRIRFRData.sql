USE ahridata;

DROP PROCEDURE IF Exists GetAHRIRFRData;

DELIMITER $$
CREATE PROCEDURE GetAHRIRFRData(
	p_Skip int,
	p_Top int,
	p_WhereClause varchar(4000)
)
BEGIN

	set @s = concat('SELECT (SELECT count(*) from ahrirfrdata ahd WHERE ', p_WhereClause, 
              ') as TotalRows, AHRIReferenceNumber, Model from ahrirfrdata ahd WHERE ', p_WhereClause, 
	         ' order by Model, AHRIReferenceNumber LIMIT ', p_Skip, ', ', p_Top);
	
	PREPARE stmt2 FROM @s;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;
END$$
DELIMITER ;

