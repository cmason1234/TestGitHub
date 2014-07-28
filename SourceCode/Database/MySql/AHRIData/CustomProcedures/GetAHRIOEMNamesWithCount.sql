USE ahridata;

DROP PROCEDURE IF Exists GetAHRIOEMNamesWithCount;

DELIMITER $$
CREATE PROCEDURE GetAHRIOEMNamesWithCount(
    p_AHRIDataType varchar(256)
)
BEGIN

   if p_AHRIDataType = 'AC' THEN
     select OEMTradeName, count(AHRIReferenceNumber) as NumItems 
	     from ahriacoemnames group by OEMTradeName order by NumItems desc;
   ELSEIF p_AHRIDataType = 'HEAT PUMP' THEN
     select OEMTradeName, count(AHRIReferenceNumber) as NumItems 
	     from ahrihpoemnames group by OEMTradeName order by NumItems desc;
   ELSEIF p_AHRIDataType = 'GAS FURNACE' THEN
     select OEMTradeName, count(AHRIReferenceNumber) as NumItems 
	     from ahrirfroemnames group by OEMTradeName order by NumItems desc;
   ELSEIF p_AHRIDataType = 'WH' THEN
     select OEMTradeName, count(AHRIReferenceNumber) as NumItems 
	     from ahriwhdata group by OEMTradeName order by NumItems desc;
   ELSE
     select 'Unknown DataType Requested', 0 as NumItems;
   END IF;

END$$
DELIMITER ;
