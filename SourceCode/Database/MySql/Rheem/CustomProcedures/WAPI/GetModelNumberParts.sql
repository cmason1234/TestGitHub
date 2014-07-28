USE rheem;

DROP PROCEDURE IF Exists WAPI__ModelNumberParts__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ModelNumberParts__Get(
    IN p_modelnumber varchar(50))
BEGIN

	select Model, ModelDescription, Brand, ComponentNumber, ComponentDescription, ComponentLength,
	   ComponentWidth, ComponentHeight, ComponentWeight, Replacement, Usage_Count from ru_parts_model rpm 
	  INNER JOIN ru_parts_modelcomponent rpmc on rpm.Parts_ModelID=rpmc.Parts_ModelID
	  INNER JOIN ru_parts_component rpc on rpmc.Parts_ComponentID=rpc.Parts_ComponentID
	where model like concat(p_modelnumber, '%') order by model, componentNumber;

END$$
DELIMITER ;


