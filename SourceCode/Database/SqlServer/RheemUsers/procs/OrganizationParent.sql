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
   Get rid of obsolete InsertOrganizationParent
   Get rid of obsolete UpdateOrganizationParent
   Get rid of obsolete DeleteOrganizationParent
   Get rid of obsolete SearchOrganizationParentByString
   Get rid of obsolete GetOrganizationParentByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertOrganizationParent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertOrganizationParent;
        PRINT 'Dropped InsertOrganizationParent'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateOrganizationParent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateOrganizationParent;
        PRINT 'Dropped UpdateOrganizationParent'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteOrganizationParent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteOrganizationParent;
        PRINT 'Dropped DeleteOrganizationParent'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchOrganizationParentByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchOrganizationParentByString;
        PRINT 'Dropped SearchOrganizationParentByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetOrganizationParentByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetOrganizationParentByID;
        PRINT 'Dropped GetOrganizationParentByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__OrganizationParent_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__OrganizationParent_GetByID;
        PRINT 'Dropped spGen__OrganizationParent_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__OrganizationParent_GetByID

   Description:  Selects record(s) from table 'OrganizationParent'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__OrganizationParent_GetByID
(
    @OrganizationParentID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [OrganizationParentID],[OrganizationID],[ParentOrganizationID],[Relationship],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [OrganizationParent]
    WHERE [OrganizationParentID] = @OrganizationParentID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__OrganizationParent_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__OrganizationParent_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__OrganizationParent_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__OrganizationParent_SearchByString;
        PRINT 'Dropped spGen__OrganizationParent_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__OrganizationParent_SearchByString

   Description:  Selects a record from table 'OrganizationParent'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__OrganizationParent_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [OrganizationParentID],[OrganizationID],[ParentOrganizationID],[Relationship],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [OrganizationParent]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__OrganizationParent_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__OrganizationParent_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__OrganizationParent_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__OrganizationParent_Delete;
        PRINT 'Dropped spGen__OrganizationParent_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__OrganizationParent_Delete

   Description:  Deletes a record from table 'OrganizationParent'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__OrganizationParent_Delete
(
    @OrganizationParentID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [OrganizationParent]
    WHERE [OrganizationParentID] = @OrganizationParentID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__OrganizationParent_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__OrganizationParent_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__OrganizationParent_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__OrganizationParent_Save;
        PRINT 'Dropped spGen__OrganizationParent_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__OrganizationParent_Save

   Description:  Updates or Deletes a record In table 'OrganizationParent'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__OrganizationParent_Save
(
    @ErrText varchar(4000) output,
    @OrganizationParentID uniqueidentifier output,
    @OrganizationID uniqueidentifier,
    @ParentOrganizationID uniqueidentifier,
    @Relationship varchar(50)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @OrganizationParentID = '00000000-0000-0000-0000-000000000000' SET @OrganizationParentID = NULL
    IF @OrganizationParentID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @OrganizationParentID = NewID()

                    INSERT
                    INTO [OrganizationParent]
                    (
                        [OrganizationParentID],
                        [OrganizationID],
                        [ParentOrganizationID],
                        [Relationship],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @OrganizationParentID,
                        @OrganizationID,
                        @ParentOrganizationID,
                        @Relationship,
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
                    UPDATE [OrganizationParent]
                    SET
                    [OrganizationID] = @OrganizationID,
                    [ParentOrganizationID] = @ParentOrganizationID,
                    [Relationship] = @Relationship,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [OrganizationParentID] = @OrganizationParentID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__OrganizationParent_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__OrganizationParent_Save Error on Creation'
GO




