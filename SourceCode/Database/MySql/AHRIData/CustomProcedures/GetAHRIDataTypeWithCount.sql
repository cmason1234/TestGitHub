USE ahridata;

DROP PROCEDURE IF Exists GetAHRIDataTypeWithCount;

DELIMITER $$
CREATE PROCEDURE GetAHRIDataTypeWithCount()
BEGIN
	SELECT 'AC' as  AHRIDataType, count(*) as numItems from ahriacdata
   union
    SELECT 'HEAT PUMP', count(*) from ahrihpdata
   union
    SELECT 'GAS FURNACE', count(*) from ahrirfrdata
   union
	 SELECT 'WH', count(*) from ahriwhdata
   ORDER BY AHRIDataType;

END$$
DELIMITER ;
