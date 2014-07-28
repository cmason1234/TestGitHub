USE rheem;

DROP PROCEDURE IF Exists WAPI__DesignStarPerson__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__DesignStarPerson__Get(
    IN p_personID varchar(64))
BEGIN

	select pdj.personid, count(*) as numJobFunctions 
	from ru_persondepartmentjob pdj 
	INNER JOIN ru_departmentjobfunction djf ON pdj.DepartmentJobFunctionID = djf.DepartmentJobFunctionID
	INNER JOIN ru_jobfunction jf ON djf.JobFunctionID = jf.JobFunctionID
	INNER JOIN ru_department d ON djf.DepartmentID = d.DepartmentID
	where 
	    pdj.personid=p_personID and 
		jf.Description = 'Design Star User' and 
		d.DepartmentName ='Marketing';

END$$
DELIMITER ;