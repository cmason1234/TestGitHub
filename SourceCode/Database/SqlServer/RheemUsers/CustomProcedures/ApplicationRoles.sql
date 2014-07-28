USE [RheemUsers]
GO
/****** Object:  StoredProcedure [dbo].[GetApplicationRoleCountForPerson]    Script Date: 11/17/2010 13:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetApplicationRoleCountForPerson
   
   Description:  If user has access to Application it gets a count ''
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 8:13:49 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetApplicationRoleCountForPerson') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GetApplicationRoleCountForPerson;
		PRINT 'Dropped GetApplicationRoleCountForPerson'
	END
GO
CREATE PROCEDURE [dbo].[GetApplicationRoleCountForPerson]
(
	@RoleCount int = 0 output,
	@ApplicationName varchar(50),
	@RoleName varchar(50),
	@PersonID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SELECT @RoleCount = Count(ar.RoleID) 
	FROM rheemusers..Application a, 
	rheemusers..ApplicationRole ar,
	rheemusers..role r, 
	rheemusers..personrole pr 
    WHERE a.ApplicationName = @ApplicationName 
    AND a.ApplicationId = ar.ApplicationID 
    AND ar.roleid = r.roleid
    AND r.rolename= @RoleName
    AND pr.PersonID = @PersonID
    AND ar.ApplicationroleID = pr.applicationroleID
	
	SET @Err = @@Error

	RETURN @RoleCount
	
End
GO
/****** Object:  StoredProcedure [dbo].[GetApplicationRolesForPerson]    Script Date: 11/17/2010 13:52:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetApplicationRolesForPerson
   
   Description:  Gets all Roles and Applications for Person
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 10:13:49 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetApplicationRolesForPerson') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GetApplicationRolesForPerson;
		PRINT 'Dropped GetApplicationRolesForPerson'
	END
GO
CREATE PROCEDURE [dbo].[GetApplicationRolesForPerson]
(
	@PersonID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SELECT DISTINCT Application.FullApplicationName, Role.RoleName, Application.ApplicationName
	FROM Application INNER JOIN
	ApplicationRole ON Application.ApplicationID = ApplicationRole.ApplicationID INNER JOIN
	PersonRole ON ApplicationRole.ApplicationRoleID = PersonRole.ApplicationRoleID INNER JOIN
	Person ON PersonRole.PersonID = Person.PersonID INNER JOIN
	Role ON ApplicationRole.RoleID = Role.RoleID
	WHERE     (Person.PersonID = @PersonID)
	ORDER BY Application.ApplicationName
	
	SET @Err = @@Error

	
End
GO
