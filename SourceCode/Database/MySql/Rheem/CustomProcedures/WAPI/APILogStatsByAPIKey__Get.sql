USE rheem;

DROP PROCEDURE IF Exists WAPI__APILogStatsByAPIKey__Get;

DROP PROCEDURE IF Exists WAPI__APILogStatsByAPIKey__TopAPIs__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__APILogStatsByAPIKey__TopAPIs__Get(
	IN p_apikey varchar(50),
	IN p_begindate datetime,
	IN p_enddate datetime)
BEGIN

    select requestpath, count(apilogid) as NumHits 
	from rheem.apilog 
	where apikey = p_apikey
	and CreateDateTime__Gen between p_begindate and p_enddate + ' 23:59:59'
	group by requestpath
	order by count(*) desc
	limit 5;
	
END$$
DELIMITER ;

DROP PROCEDURE IF Exists WAPI__APILogStatsByAPIKey__TopDataSizeSum__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__APILogStatsByAPIKey__TopDataSizeSum__Get(
	IN p_apikey varchar(50),
	IN p_begindate datetime,
	IN p_enddate datetime)
BEGIN

	select requestpath, sum(responsesize) as responsesize 
	from rheem.apilog 
	where apikey = p_apikey
	and CreateDateTime__Gen between p_begindate and p_enddate + ' 23:59:59'
	group by requestpath
	order by sum(responsesize) desc
	limit 5;
	
END$$
DELIMITER ;

DROP PROCEDURE IF Exists WAPI__APILogStatsByAPIKey__TopDataSize__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__APILogStatsByAPIKey__TopDataSize__Get(
	IN p_apikey varchar(50),
	IN p_begindate datetime,
	IN p_enddate datetime)
BEGIN
	
	select requestpath, responsesize 
	from rheem.apilog 
	where apikey = p_apikey
	and CreateDateTime__Gen between p_begindate and p_enddate + ' 23:59:59'
	group by requestpath
	order by responsesize desc
	limit 5;

	END$$
DELIMITER ;

DROP PROCEDURE IF Exists WAPI__APILogStatsByAPIKey__TopResponseTime__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__APILogStatsByAPIKey__TopResponseTime__Get(
	IN p_apikey varchar(50),
	IN p_begindate datetime,
	IN p_enddate datetime)
BEGIN

	select requestpath, responsetime 
	from rheem.apilog 
	where apikey = p_apikey
	and CreateDateTime__Gen between p_begindate and p_enddate + ' 23:59:59'
	group by requestpath
	order by responsetime desc
	limit 5;

END$$
DELIMITER ;
