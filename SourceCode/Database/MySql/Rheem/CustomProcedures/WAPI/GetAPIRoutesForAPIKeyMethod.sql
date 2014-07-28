USE rheem;

DROP PROCEDURE IF Exists WAPI__GetAPIRoutesForAPIKeyMethod;

DELIMITER $$
CREATE PROCEDURE WAPI__GetAPIRoutesForAPIKeyMethod(
    IN p_routeStart varchar(50),
    IN p_accessKeyID varchar(50),
    IN p_httpMethod varchar(256))
BEGIN

	SELECT RoutePath, am.APIAccessKeyID 
	  FROM ru_apiroute ar
		INNER JOIN rheem.ru_apiaccessmatrix am ON am.APIRouteID=ar.APIRouteID
	WHERE ar.RoutePath like CONCAT(p_routeStart, '%') AND 
		am.APIAccessKeyID = p_accessKeyID AND 
		ar.HttpMethod = p_httpMethod;

END$$
DELIMITER ;

