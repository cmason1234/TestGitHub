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
   Get rid of obsolete InsertDocumentFolder
   Get rid of obsolete UpdateDocumentFolder
   Get rid of obsolete DeleteDocumentFolder
   Get rid of obsolete SearchDocumentFolderByString
   Get rid of obsolete GetDocumentFolderByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertDocumentFolder') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertDocumentFolder;
        PRINT 'Dropped InsertDocumentFolder'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateDocumentFolder') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateDocumentFolder;
        PRINT 'Dropped UpdateDocumentFolder'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteDocumentFolder') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteDocumentFolder;
        PRINT 'Dropped DeleteDocumentFolder'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchDocumentFolderByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchDocumentFolderByString;
        PRINT 'Dropped SearchDocumentFolderByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetDocumentFolderByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetDocumentFolderByID;
        PRINT 'Dropped GetDocumentFolderByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__DocumentFolder_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__DocumentFolder_GetByID;
        PRINT 'Dropped spGen__DocumentFolder_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__DocumentFolder_GetByID

   Description:  Selects record(s) from table 'DocumentFolder'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__DocumentFolder_GetByID
(
    @DocumentFolderID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [DocumentFolderID],[FolderName],[ParentDocumentFolderID],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [DocumentFolder]
    WHERE [DocumentFolderID] = @DocumentFolderID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__DocumentFolder_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__DocumentFolder_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__DocumentFolder_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__DocumentFolder_SearchByString;
        PRINT 'Dropped spGen__DocumentFolder_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__DocumentFolder_SearchByString

   Description:  Selects a record from table 'DocumentFolder'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__DocumentFolder_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [DocumentFolderID],[FolderName],[ParentDocumentFolderID],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [DocumentFolder]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__DocumentFolder_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__DocumentFolder_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__DocumentFolder_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__DocumentFolder_Delete;
        PRINT 'Dropped spGen__DocumentFolder_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__DocumentFolder_Delete

   Description:  Deletes a record from table 'DocumentFolder'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__DocumentFolder_Delete
(
    @DocumentFolderID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [DocumentFolder]
    WHERE [DocumentFolderID] = @DocumentFolderID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__DocumentFolder_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__DocumentFolder_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__DocumentFolder_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__DocumentFolder_Save;
        PRINT 'Dropped spGen__DocumentFolder_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__DocumentFolder_Save

   Description:  Updates or Deletes a record In table 'DocumentFolder'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__DocumentFolder_Save
(
    @ErrText varchar(4000) output,
    @DocumentFolderID uniqueidentifier output,
    @FolderName varchar(100),
    @ParentDocumentFolderID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @DocumentFolderID = '00000000-0000-0000-0000-000000000000' SET @DocumentFolderID = NULL
    IF @DocumentFolderID IS NULL
        BEGIN
            SELECT @UniqueRowCount = COUNT(1) FROM [DocumentFolder] where [FolderName] = @FolderName 
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = 'FolderName ' + Convert(varchar(36), @FolderName) + ' already exists'
                END
            ELSE
                BEGIN
                    SET @DocumentFolderID = NewID()

                    INSERT
                    INTO [DocumentFolder]
                    (
                        [DocumentFolderID],
                        [FolderName],
                        [ParentDocumentFolderID],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @DocumentFolderID,
                        @FolderName,
                        @ParentDocumentFolderID,
                        SYSDATETIME(),
                        SYSDATETIME()
                    )
                END
        END
    ELSE
        BEGIN
            -- check to see that there isn't another row like this one (assuming the unique index column(s) might have changed)
            SELECT @UniqueRowCount = COUNT(1) FROM [DocumentFolder] where [FolderName] = @FolderName  and [DocumentFolderID] <> @DocumentFolderID
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = 'FolderName ' + Convert(varchar(36), @FolderName) + ' already exists'
                END
            ELSE
                BEGIN
                    UPDATE [DocumentFolder]
                    SET
                    [FolderName] = @FolderName,
                    [ParentDocumentFolderID] = @ParentDocumentFolderID,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [DocumentFolderID] = @DocumentFolderID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__DocumentFolder_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__DocumentFolder_Save Error on Creation'
GO




