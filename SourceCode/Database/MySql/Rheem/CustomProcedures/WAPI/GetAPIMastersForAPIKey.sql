USE rheem;

DROP PROCEDURE IF Exists WAPI__GetAPIMastersForAPIKey;

DELIMITER $$
CREATE PROCEDURE WAPI__GetAPIMastersForAPIKey(
    IN p_accessKey varchar(50),
    IN p_secretKey varchar(256))
BEGIN


	SELECT distinct m.APIName 
	FROM rheem.ru_apimaster m
		INNER JOIN rheem.ru_apiroute r ON r.APIMasterID = m.APIMasterID
		INNER JOIN rheem.ru_apiaccessmatrix am ON am.APIRouteID = r.APIRouteID
		INNER JOIN rheem.ru_apiaccesskey ak ON ak.APIAccessKeyID = am.APIAccessKeyID
	WHERE ak.AccessKey=p_accessKey and 
		  ak.SecretKey=p_secretKey;

END$$
DELIMITER ;

