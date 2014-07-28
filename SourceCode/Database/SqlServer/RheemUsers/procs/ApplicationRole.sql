/*
'===============================================================================
' Generated by GenerateDataAndObjectLayer Version 1.0.0.0
'
' <auto-generated>
'     This code was generated by a tool.
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated. 
' </auto-generated>
'===============================================================================

*/
USE [RheemUsers]

/* ------------------------------------------------------------
   Get rid of obsolete InsertApplicationRole
   Get rid of obsolete UpdateApplicationRole
   Get rid of obsolete DeleteApplicationRole
   Get rid of obsolete SearchApplicationRoleByString
   Get rid of obsolete GetApplicationRoleByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertApplicationRole') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertApplicationRole;
        PRINT 'Dropped InsertApplicationRole'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateApplicationRole') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateApplicationRole;
        PRINT 'Dropped UpdateApplicationRole'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteApplicationRole') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteApplicationRole;
        PRINT 'Dropped DeleteApplicationRole'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchApplicationRoleByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchApplicationRoleByString;
        PRINT 'Dropped SearchApplicationRoleByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetApplicationRoleByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetApplicationRoleByID;
        PRINT 'Dropped GetApplicationRoleByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ApplicationRole_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ApplicationRole_GetByID;
        PRINT 'Dropped spGen__ApplicationRole_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ApplicationRole_GetByID

   Description:  Selects record(s) from table 'ApplicationRole'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ApplicationRole_GetByID
(
    @ApplicationRoleID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ApplicationRoleID],[ApplicationID],[RoleID],[RoleCategoryID],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ApplicationRole]
    WHERE [ApplicationRoleID] = @ApplicationRoleID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ApplicationRole_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ApplicationRole_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ApplicationRole_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ApplicationRole_SearchByString;
        PRINT 'Dropped spGen__ApplicationRole_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ApplicationRole_SearchByString

   Description:  Selects a record from table 'ApplicationRole'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ApplicationRole_SearchByString
(
    @searchParam varchar(8000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(8000)

    SET @strSql = ' Select [ApplicationRoleID],[ApplicationID],[RoleID],[RoleCategoryID],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ApplicationRole]
    WHERE ' +  @searchParam

    EXEC(@strSql)

    --//We should NOT be using exec above.
    --//If params are NOT known, then be sure to clean sql
    --//If params are known, format like example below

    --IF @prodname IS NOT NULL
    --SELECT @sql = @sql + ' ProductName LIKE @prodname'
    --EXEC sp_executesql @sql, N'@prodname varchar(400)',@prodname

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ApplicationRole_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ApplicationRole_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ApplicationRole_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ApplicationRole_Delete;
        PRINT 'Dropped spGen__ApplicationRole_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ApplicationRole_Delete

   Description:  Deletes a record from table 'ApplicationRole'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ApplicationRole_Delete
(
    @ApplicationRoleID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ApplicationRole]
    WHERE [ApplicationRoleID] = @ApplicationRoleID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ApplicationRole_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ApplicationRole_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ApplicationRole_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ApplicationRole_Save;
        PRINT 'Dropped spGen__ApplicationRole_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ApplicationRole_Save

   Description:  Updates or Deletes a record In table 'ApplicationRole'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ApplicationRole_Save
(
    @ErrText varchar(4000) output,
    @ApplicationRoleID uniqueidentifier output,
    @ApplicationID uniqueidentifier,
    @RoleID uniqueidentifier,
    @RoleCategoryID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ApplicationRoleID = '00000000-0000-0000-0000-000000000000' SET @ApplicationRoleID = NULL
    IF @ApplicationRoleID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ApplicationRoleID = NewID()

                    INSERT
                    INTO [ApplicationRole]
                    (
                        [ApplicationRoleID],
                        [ApplicationID],
                        [RoleID],
                        [RoleCategoryID],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @ApplicationRoleID,
                        @ApplicationID,
                        @RoleID,
                        @RoleCategoryID,
                        SYSDATETIME(),
                        SYSDATETIME()
                    )
                END
        END
    ELSE
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    UPDATE [ApplicationRole]
                    SET
                    [ApplicationID] = @ApplicationID,
                    [RoleID] = @RoleID,
                    [RoleCategoryID] = @RoleCategoryID,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [ApplicationRoleID] = @ApplicationRoleID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ApplicationRole_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ApplicationRole_Save Error on Creation'
GO




