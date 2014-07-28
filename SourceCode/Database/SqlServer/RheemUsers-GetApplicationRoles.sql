USE [RheemUsers]
GO

/****** Object:  StoredProcedure [dbo].[GetApplicationRolesForPerson]    Script Date: 10/27/2010 12:30:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetApplicationRolesForPerson
   
   Description:  Gets all Roles and Applications for Person
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 10:13:49 AM
   ------------------------------------------------------------ */

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


