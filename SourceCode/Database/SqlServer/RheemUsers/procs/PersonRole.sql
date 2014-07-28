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
   Get rid of obsolete InsertPersonRole
   Get rid of obsolete UpdatePersonRole
   Get rid of obsolete DeletePersonRole
   Get rid of obsolete SearchPersonRoleByString
   Get rid of obsolete GetPersonRoleByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertPersonRole') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertPersonRole;
        PRINT 'Dropped InsertPersonRole'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatePersonRole') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdatePersonRole;
        PRINT 'Dropped UpdatePersonRole'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletePersonRole') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeletePersonRole;
        PRINT 'Dropped DeletePersonRole'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchPersonRoleByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchPersonRoleByString;
        PRINT 'Dropped SearchPersonRoleByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetPersonRoleByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetPersonRoleByID;
        PRINT 'Dropped GetPersonRoleByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__PersonRole_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__PersonRole_GetByID;
        PRINT 'Dropped spGen__PersonRole_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__PersonRole_GetByID

   Description:  Selects record(s) from table 'PersonRole'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__PersonRole_GetByID
(
    @PersonRoleID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [PersonRoleID],[PersonID],[ApplicationRoleID],[DeleteColumn],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [PersonRole]
    WHERE [PersonRoleID] = @PersonRoleID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__PersonRole_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__PersonRole_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__PersonRole_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__PersonRole_SearchByString;
        PRINT 'Dropped spGen__PersonRole_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__PersonRole_SearchByString

   Description:  Selects a record from table 'PersonRole'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__PersonRole_SearchByString
(
    @searchParam varchar(8000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(8000)

    SET @strSql = ' Select [PersonRoleID],[PersonID],[ApplicationRoleID],[DeleteColumn],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [PersonRole]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__PersonRole_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__PersonRole_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__PersonRole_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__PersonRole_Delete;
        PRINT 'Dropped spGen__PersonRole_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__PersonRole_Delete

   Description:  Deletes a record from table 'PersonRole'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__PersonRole_Delete
(
    @PersonRoleID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [PersonRole]
    WHERE [PersonRoleID] = @PersonRoleID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__PersonRole_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__PersonRole_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__PersonRole_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__PersonRole_Save;
        PRINT 'Dropped spGen__PersonRole_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__PersonRole_Save

   Description:  Updates or Deletes a record In table 'PersonRole'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__PersonRole_Save
(
    @ErrText varchar(4000) output,
    @PersonRoleID uniqueidentifier output,
    @PersonID uniqueidentifier,
    @ApplicationRoleID uniqueidentifier,
    @DeleteColumn char(10)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @PersonRoleID = '00000000-0000-0000-0000-000000000000' SET @PersonRoleID = NULL
    IF @PersonRoleID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @PersonRoleID = NewID()

                    INSERT
                    INTO [PersonRole]
                    (
                        [PersonRoleID],
                        [PersonID],
                        [ApplicationRoleID],
                        [DeleteColumn],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @PersonRoleID,
                        @PersonID,
                        @ApplicationRoleID,
                        @DeleteColumn,
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
                    UPDATE [PersonRole]
                    SET
                    [PersonID] = @PersonID,
                    [ApplicationRoleID] = @ApplicationRoleID,
                    [DeleteColumn] = @DeleteColumn,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [PersonRoleID] = @PersonRoleID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__PersonRole_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__PersonRole_Save Error on Creation'
GO




