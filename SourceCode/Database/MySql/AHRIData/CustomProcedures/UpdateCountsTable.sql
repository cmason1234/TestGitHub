USE ahridata;

DROP PROCEDURE IF Exists UpdateCountsTable;

DELIMITER $$
CREATE PROCEDURE UpdateCountsTable(
    p_AHRIDataType varchar(256)
)
BEGIN

   if p_AHRIDataType = 'AC' THEN
	delete from ahricounts where ahriType='AC';

	insert into ahricounts (ahriType, columnCounted, columnValue, columnCount, sortOrder) 
		select 'AC', 'OEMTradeName', OEMTradeName, count(*), IFNULL(aro.SortOrder, 0) from ahriacoemnames aho 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'AC' and aro.columnCounted='OEMTradeName' group by OEMTradeName
	UNION
		select 'AC', 'IsActive', 'No', count(*), IFNULL(aro.SortOrder, 0) from ahriacdata acd
		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'AC' and aro.columnCounted='IsActive'
		  where IsActive=0
	UNION
		select 'AC', 'IsActive', 'Yes', count(*), IFNULL(aro.SortOrder, 0) from ahriacdata acd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'AC' and aro.columnCounted='IsActive'
		where IsActive=1	
	UNION
		select 'AC', 'ManufacturerType', ManufacturerType, count(*), IFNULL(aro.SortOrder, 0) from ahriacdata acd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'AC' and aro.columnCounted='ManufacturerType'
		group by ManufacturerType
	UNION
		select 'AC', 'OutdoorUnitManufacturer', OutdoorUnitManufacturer, count(*), IFNULL(aro.SortOrder, 0) from ahriacdata acd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'AC' and aro.columnCounted='OutdoorUnitManufacturer'
		group by OutdoorUnitManufacturer
	UNION
		select 'AC', 'IndoorUnitManufacturer', IndoorUnitManufacturer, count(*), IFNULL(aro.SortOrder, 0) from ahriacdata acd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'AC' and aro.columnCounted='IndoorUnitManufacturer'
		group by IndoorUnitManufacturer;

   ELSEIF p_AHRIDataType = 'HP' THEN
     delete from ahricounts where ahriType='HP';

	insert into ahricounts (ahriType, columnCounted, columnValue, columnCount, sortOrder) 
		select 'HP', 'OEMTradeName', OEMTradeName, count(*), IFNULL(aro.SortOrder, 0) from ahrihpoemnames aho 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'HP' and aro.columnCounted='OEMTradeName' group by OEMTradeName
	   UNION
		select 'HP', 'IsActive', 'No', count(*), IFNULL(aro.SortOrder, 0) from ahrihpdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'HP' and aro.columnCounted='IsActive' where IsActive=0
	   UNION
		select 'HP', 'IsActive', 'Yes', count(*), IFNULL(aro.SortOrder, 0) from ahrihpdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'HP' and aro.columnCounted='IsActive' where IsActive=1;
	 
   ELSEIF p_AHRIDataType = 'RFR' THEN
     delete from ahricounts where ahriType='RFR';

	insert into ahricounts (ahriType, columnCounted, columnValue, columnCount, sortOrder) 
		select 'RFR', 'OEMTradeName', OEMTradeName, count(*), IFNULL(aro.SortOrder, 0) from ahrirfroemnames aho 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='OEMTradeName' 
		  group by OEMTradeName
	   UNION
		select 'RFR', 'IsActive', 'No', count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='IsActive' where IsActive=0
	   UNION
		select 'RFR', 'IsActive', 'Yes', count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='IsActive' where IsActive=1	
	   UNION
		select 'RFR', 'Manufacturer', Manufacturer, count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='Manufacturer' group by Manufacturer
	   UNION
		select 'RFR', 'FuelType', 'Natural Gas', count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='FuelType' where FuelNaturalGas=1
	   UNION
		select 'RFR', 'FuelType', 'Propane Gas', count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='FuelType' where FuelPropaneGas=1
	   UNION
		select 'RFR', 'FuelType', 'Oil', count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='FuelType' where FuelOil=1
	   UNION
		select 'RFR', 'Configuration', 'UpFlow', count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='Configuration' where UpFlow=1
	   UNION
		select 'RFR', 'Configuration', 'DownFlow', count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='Configuration' where DownFlow=1
	   UNION
		select 'RFR', 'Configuration', 'Horizontal', count(*), IFNULL(aro.SortOrder, 0) from ahrirfrdata ahd
		INNER JOIN ahriresultsorder aro on aro.ahriType = 'RFR' and aro.columnCounted='Configuration' where Horizontal=1;

   ELSEIF p_AHRIDataType = 'WH' THEN
    delete from ahricounts where ahriType='WH';

	insert into ahricounts (ahriType, columnCounted, columnValue, columnCount, sortOrder) 
		select 'WH', 'OEMTradeName', OEMTradeName, count(*), IFNULL(aro.SortOrder, 0) from ahriwhdata awh 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'WH' and aro.columnCounted='OEMTradeName' group by OEMTradeName
	   UNION
		select 'WH', 'EnergySource', EnergySource, count(*), IFNULL(aro.SortOrder, 0) from ahriwhdata awh 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'WH' and aro.columnCounted='EnergySource' group by EnergySource
	   UNION
		select 'WH', 'TaxCredit', 'No', count(*), IFNULL(aro.SortOrder, 0) from ahriwhdata awh 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'WH' and aro.columnCounted='TaxCredit' where TaxCredit=0
	   UNION
		select 'WH', 'TaxCredit', 'Yes', count(*), IFNULL(aro.SortOrder, 0) from ahriwhdata awh 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'WH' and aro.columnCounted='TaxCredit' where TaxCredit=1
	   UNION
		select 'WH', 'HeaterType', HeaterType, count(*), IFNULL(aro.SortOrder, 0) from ahriwhdata awh 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'WH' and aro.columnCounted='HeaterType' group by HeaterType
	   UNION
		select 'WH', 'IsActive', 'No', count(*), IFNULL(aro.SortOrder, 0) from ahriwhdata awh 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'WH' and aro.columnCounted='IsActive' where IsActive=0
	   UNION
		select 'WH', 'IsActive', 'Yes', count(*), IFNULL(aro.SortOrder, 0) from ahriwhdata awh 
  		  INNER JOIN ahriresultsorder aro on aro.ahriType = 'WH' and aro.columnCounted='IsActive' where IsActive=1;
   END IF;

END$$
DELIMITER ;
