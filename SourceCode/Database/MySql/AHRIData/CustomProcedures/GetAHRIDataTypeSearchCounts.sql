USE ahridata;

DROP PROCEDURE IF Exists GetAHRIDataTypeSearchCounts;

DELIMITER $$
CREATE PROCEDURE GetAHRIDataTypeSearchCounts(
	p_AHRIDataType varchar(256)
)
BEGIN
	SELECT ahrircountsID, ahriType, columnCounted, columnValue, columnCount
	 from ahricounts where ahriType=p_AHRIDataType
		order by sortOrder, ahriType, columnCounted, columnCount desc;
END$$
DELIMITER ;
