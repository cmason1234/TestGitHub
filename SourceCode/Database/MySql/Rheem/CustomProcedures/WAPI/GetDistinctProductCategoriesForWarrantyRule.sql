USE rheem;

DROP PROCEDURE IF Exists WAPI__GetDistinctProductCategoriesForWarrantyRule;

DELIMITER $$
CREATE PROCEDURE WAPI__GetDistinctProductCategoriesForWarrantyRule(
    IN p_modelWarrantyRuleId varchar(64))
BEGIN

	SELECT COUNT(DISTINCT p.ProductCategoryID) As categoryCount, 'junk' As ToMakeItWork
	FROM ru_modelwarrantyrulemodel rm 
		INNER JOIN ru_product p ON p.ProductID = rm.ProductID
	WHERE rm.ModelWarrantyRuleID = p_modelWarrantyRuleId;

END$$
DELIMITER ;


