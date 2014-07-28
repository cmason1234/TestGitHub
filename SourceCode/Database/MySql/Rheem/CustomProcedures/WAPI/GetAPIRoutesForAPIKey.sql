USE rheem;

DROP PROCEDURE IF Exists WAPI__GetAPIRoutesForAPIKey;

DELIMITER $$
CREATE PROCEDURE WAPI__GetAPIRoutesForAPIKey(
    IN p_accessKey varchar(50),
    IN p_secretKey varchar(256),
	IN p_apiMasterId varchar(36))
BEGIN

	SELECT r.RoutePath,r.HttpMethod,r.ActionName, r.APIRouteID, am.APIAccessMatrixID
	FROM rheem.ru_apiaccesskey k 
      INNER JOIN rheem.ru_apiaccessmatrix am ON k.APIAccessKeyID=am.APIAccessKeyID
      INNER JOIN rheem.ru_apiroute r ON am.APIRouteID=r.APIRouteID and
              r.APIMasterID = p_apiMasterId
	WHERE 
		  k.AccessKey=p_accessKey and
		  k.SecretKey=p_secretKey and
		  k.Active=1;

END$$
DELIMITER ;

