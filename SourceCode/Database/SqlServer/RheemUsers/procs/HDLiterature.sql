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
   Get rid of obsolete InsertHDLiterature
   Get rid of obsolete UpdateHDLiterature
   Get rid of obsolete DeleteHDLiterature
   Get rid of obsolete SearchHDLiteratureByString
   Get rid of obsolete GetHDLiteratureByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertHDLiterature') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertHDLiterature;
        PRINT 'Dropped InsertHDLiterature'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateHDLiterature') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateHDLiterature;
        PRINT 'Dropped UpdateHDLiterature'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteHDLiterature') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteHDLiterature;
        PRINT 'Dropped DeleteHDLiterature'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchHDLiteratureByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchHDLiteratureByString;
        PRINT 'Dropped SearchHDLiteratureByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetHDLiteratureByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetHDLiteratureByID;
        PRINT 'Dropped GetHDLiteratureByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDLiterature_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDLiterature_GetByID;
        PRINT 'Dropped spGen__HDLiterature_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDLiterature_GetByID

   Description:  Selects record(s) from table 'HDLiterature'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDLiterature_GetByID
(
    @HDLiteratureID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [HDLiteratureID],[LiteratureNumber],[Description],[BundleCount],[PreviewPDFURL],[IConURL],[Restrictions],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HDLiterature]
    WHERE [HDLiteratureID] = @HDLiteratureID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDLiterature_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__HDLiterature_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDLiterature_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDLiterature_SearchByString;
        PRINT 'Dropped spGen__HDLiterature_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDLiterature_SearchByString

   Description:  Selects a record from table 'HDLiterature'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDLiterature_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [HDLiteratureID],[LiteratureNumber],[Description],[BundleCount],[PreviewPDFURL],[IConURL],[Restrictions],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HDLiterature]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDLiterature_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__HDLiterature_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDLiterature_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDLiterature_Delete;
        PRINT 'Dropped spGen__HDLiterature_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDLiterature_Delete

   Description:  Deletes a record from table 'HDLiterature'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDLiterature_Delete
(
    @HDLiteratureID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [HDLiterature]
    WHERE [HDLiteratureID] = @HDLiteratureID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDLiterature_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__HDLiterature_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDLiterature_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDLiterature_Save;
        PRINT 'Dropped spGen__HDLiterature_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDLiterature_Save

   Description:  Updates or Deletes a record In table 'HDLiterature'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDLiterature_Save
(
    @ErrText varchar(4000) output,
    @HDLiteratureID uniqueidentifier output,
    @LiteratureNumber varchar(50),
    @Description varchar(256),
    @BundleCount int,
    @PreviewPDFURL varchar(50),
    @IConURL varchar(50),
    @Restrictions varchar(50)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @HDLiteratureID = '00000000-0000-0000-0000-000000000000' SET @HDLiteratureID = NULL
    IF @HDLiteratureID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @HDLiteratureID = NewID()

                    INSERT
                    INTO [HDLiterature]
                    (
                        [HDLiteratureID],
                        [LiteratureNumber],
                        [Description],
                        [BundleCount],
                        [PreviewPDFURL],
                        [IConURL],
                        [Restrictions],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @HDLiteratureID,
                        @LiteratureNumber,
                        @Description,
                        @BundleCount,
                        @PreviewPDFURL,
                        @IConURL,
                        @Restrictions,
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
                    UPDATE [HDLiterature]
                    SET
                    [LiteratureNumber] = @LiteratureNumber,
                    [Description] = @Description,
                    [BundleCount] = @BundleCount,
                    [PreviewPDFURL] = @PreviewPDFURL,
                    [IConURL] = @IConURL,
                    [Restrictions] = @Restrictions,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [HDLiteratureID] = @HDLiteratureID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDLiterature_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__HDLiterature_Save Error on Creation'
GO




