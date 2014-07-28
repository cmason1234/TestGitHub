USE support;

drop procedure if exists GetRouteExceptions;

delimiter $$
create procedure GetRouteExceptions(
    IN p_StartDate datetime,
	IN p_EndDate datetime,
	IN p_domain varchar(255),
	IN p_controller varchar(255),
	IN p_numRoutes int
	)
begin
	SELECT Route,HttpMethod,COUNT(*) As ExceptionCount
	FROM support.apilog
	WHERE CreateDateTime__Gen between p_StartDate and p_EndDate and
		  (p_domain IS NULL OR Route like CONCAT('/v1/', p_domain, '/%')) and
		  (p_controller IS NULL OR ControllerName = p_controller) and
		  IsException = 1
	GROUP BY Route,HttpMethod
	ORDER BY COUNT(*) desc
	LIMIT p_numRoutes;
	 
end; $$
delimiter ';'

