USE ahridata;

DROP PROCEDURE IF Exists GetCountsWithSearch;

DELIMITER $$
CREATE PROCEDURE GetCountsWithSearch(
    p_AHRIDataType varchar(256),
	p_WhereClause varchar(4000)
)
BEGIN

	-- Uncomment this select statement, if we need to reimport this to the EDMX file.
	--  It is here to make the EDMX happy and for no other reason.
    -- Select 'OEMTradeName' as columnCounted, OEMTradeName as columnValue, count(*) as numRows, 0 as SortOrder from ahriacoemnames;


   if p_AHRIDataType = 'AC' THEN
		set @s = concat(
			'SELECT \'OEMTradeName\' as columnCounted, aho.OEMTradeName as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) as SortOrder from ahriacoemnames aho ',
			    'INNER JOIN ahriacdata acd on aho.AHRIReferenceNumber=acd.AHRIReferenceNumber ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'AC\' and aro.columnCounted=\'OEMTradeName\' WHERE ', p_WhereClause,
				' group by aho.OEMTradeName UNION ',
			'SELECT \'IsActive\' as columnCounted, \'No\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriacdata acd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'AC\' and aro.columnCounted=\'IsActive\' ',
				'WHERE IsActive=0 AND ',  p_WhereClause, ' UNION ',
			'SELECT \'IsActive\' as columnCounted, \'Yes\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriacdata acd ',
			    'INNER JOIN ahriresultsorder aro on aro.ahriType = \'AC\' and aro.columnCounted=\'IsActive\' ',
			    'WHERE IsActive=1 AND ', p_WhereClause, ' UNION ',
			'SELECT \'ManufacturerType\' as columnCounted, ManufacturerType as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriacdata acd ',
			    'INNER JOIN ahriresultsorder aro on aro.ahriType = \'AC\' and aro.columnCounted=\'ManufacturerType\' WHERE ',
			     p_WhereClause, ' group by ManufacturerType UNION ',
			'SELECT \'OutdoorUnitManufacturer\' as columnCounted, OutdoorUnitManufacturer as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriacdata acd ',
			    'INNER JOIN ahriresultsorder aro on aro.ahriType = \'AC\' and aro.columnCounted=\'OutdoorUnitManufacturer\' WHERE ', p_WhereClause,
			    ' group by OutdoorUnitManufacturer UNION ',
			'SELECT \'IndoorUnitManufacturer\' as columnCounted, IndoorUnitManufacturer as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriacdata acd ',
			    'INNER JOIN ahriresultsorder aro on aro.ahriType = \'AC\' and aro.columnCounted=\'IndoorUnitManufacturer\' WHERE ', p_WhereClause,
			    'group by IndoorUnitManufacturer ORDER BY SortOrder, columnCounted, numRows desc, columnValue');

		PREPARE stmt FROM @s;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
   ELSEIF p_AHRIDataType = 'HP' THEN
		set @s = concat(
			'SELECT \'OEMTradeName\' as columnCounted, aho.OEMTradeName as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) as SortOrder from ahrihpoemnames aho ',
			    'INNER JOIN ahrihpdata ahd on aho.AHRIReferenceNumber=ahd.AHRIReferenceNumber ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'HP\' and aro.columnCounted=\'OEMTradeName\' WHERE ', p_WhereClause,
				' group by aho.OEMTradeName UNION ',
			'SELECT \'IsActive\' as columnCounted, \'No\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrihpdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'HP\' and aro.columnCounted=\'IsActive\' ',
				'WHERE IsActive=0 AND ', p_WhereClause, ' UNION ',
			'SELECT \'IsActive\' as columnCounted, \'Yes\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrihpdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'HP\' and aro.columnCounted=\'IsActive\' ',
				'WHERE IsActive=1 AND ', p_WhereClause, ' ORDER BY SortOrder, columnCounted, numRows desc, columnValue');

		PREPARE stmt FROM @s;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	 
   ELSEIF p_AHRIDataType = 'RFR' THEN
		set @s = concat(
			'SELECT \'OEMTradeName\' as columnCounted, aho.OEMTradeName as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) as SortOrder from ahrirfroemnames aho ',
			    'INNER JOIN ahrirfrdata ahd on aho.AHRIReferenceNumber=ahd.AHRIReferenceNumber ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'OEMTradeName\' WHERE ', p_WhereClause,
				' group by aho.OEMTradeName UNION ',
			'SELECT \'IsActive\' as columnCounted, \'No\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'IsActive\' WHERE ',
				'IsActive=0 AND ', p_WhereClause, ' UNION ',
			'SELECT \'IsActive\' as columnCounted, \'Yes\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'IsActive\' WHERE ',
				'IsActive=1 AND ', p_WhereClause, ' UNION '
			'SELECT \'Manufacturer\' as columnCounted, Manufacturer as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'Manufacturer\' WHERE ', p_WhereClause,
				' group by Manufacturer UNION ',
			'SELECT \'FuelType\' as columnCounted, \'Natural Gas\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'FuelType\' WHERE ',
				'FuelNaturalGas=1 AND ', p_WhereClause, ' UNION ',
			'SELECT \'FuelType\' as columnCounted, \'Propane Gas\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'FuelType\' WHERE ',
				'FuelPropaneGas=1 AND ', p_WhereClause, ' UNION ',
			'SELECT \'FuelType\' as columnCounted, \'Oil\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'FuelType\' WHERE '
				'FuelOil=1 AND ', p_WhereClause, ' UNION ',
			'SELECT \'Configuration\' as columnCounted, \'UpFlow\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'Configuration\' WHERE '
				'UpFlow=1 AND ', p_WhereClause, ' UNION ',
			'SELECT \'Configuration\' as columnCounted, \'DownFlow\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'Configuration\' WHERE ',
				'DownFlow=1 AND ', p_WhereClause, ' UNION ',
			'SELECT \'Configuration\' as columnCounted, \'Horizontal\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd ',
				'INNER JOIN ahriresultsorder aro on aro.ahriType = \'RFR\' and aro.columnCounted=\'Configuration\' WHERE '
				'Horizontal=1 AND ', p_WhereClause, ' ORDER BY SortOrder, columnCounted, numRows desc, columnValue');

		PREPARE stmt FROM @s;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;

   ELSEIF p_AHRIDataType = 'WH' THEN
		set @s = concat(
		'SELECT \'OEMTradeName\' as columnCounted, OEMTradeName as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) as SortOrder from ahriwhdata awh ',
			'INNER JOIN ahriresultsorder aro on aro.ahriType = \'WH\' and aro.columnCounted=\'OEMTradeName\' WHERE ',
			p_WhereClause, ' group by OEMTradeName UNION ',
		'SELECT \'EnergySource\' as columnCounted, EnergySource as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriwhdata awh ',
			'INNER JOIN ahriresultsorder aro on aro.ahriType = \'WH\' and aro.columnCounted=\'EnergySource\' WHERE ',
			p_WhereClause, ' group by EnergySource UNION ',
		'SELECT \'TaxCredit\' as columnCounted, \'No\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriwhdata awh ',
			'INNER JOIN ahriresultsorder aro on aro.ahriType = \'WH\' and aro.columnCounted=\'TaxCredit\' WHERE ',
			'TaxCredit=0 AND ', p_WhereClause, ' UNION ',
		'SELECT \'TaxCredit\' as columnCounted, \'Yes\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriwhdata awh ',
			'INNER JOIN ahriresultsorder aro on aro.ahriType = \'WH\' and aro.columnCounted=\'TaxCredit\' WHERE ',
			'TaxCredit=1 AND ', p_WhereClause, ' UNION ',
		'SELECT \'HeaterType\' as columnCounted, HeaterType as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriwhdata awh ',
			'INNER JOIN ahriresultsorder aro on aro.ahriType = \'WH\' and aro.columnCounted=\'HeaterType\' WHERE ',
			p_WhereClause, ' group by HeaterType UNION ',
		'SELECT \'IsActive\' as columnCounted, \'No\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriwhdata awh ',
			'INNER JOIN ahriresultsorder aro on aro.ahriType = \'WH\' and aro.columnCounted=\'IsActive\' WHERE ',
			'IsActive=0 AND ', p_WhereClause, ' UNION ',
		'SELECT \'IsActive\' as columnCounted, \'Yes\' as columnValue, count(*) as numRows, IFNULL(aro.SortOrder, 0) from ahriwhdata awh ',
			'INNER JOIN ahriresultsorder aro on aro.ahriType = \'WH\' and aro.columnCounted=\'IsActive\' WHERE ',
			'IsActive=1 AND ', p_WhereClause, ' ORDER BY SortOrder, columnCounted, numRows desc, columnValue');

		PREPARE stmt FROM @s;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	END IF;

   

END$$
DELIMITER ;
