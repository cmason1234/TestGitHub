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
USE [Products]

/* ------------------------------------------------------------
   Get rid of obsolete InsertProductDocument
   Get rid of obsolete UpdateProductDocument
   Get rid of obsolete DeleteProductDocument
   Get rid of obsolete SearchProductDocumentByString
   Get rid of obsolete GetProductDocumentByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertProductDocument') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertProductDocument;
        PRINT 'Dropped InsertProductDocument'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateProductDocument') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateProductDocument;
        PRINT 'Dropped UpdateProductDocument'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteProductDocument') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteProductDocument;
        PRINT 'Dropped DeleteProductDocument'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchProductDocumentByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchProductDocumentByString;
        PRINT 'Dropped SearchProductDocumentByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetProductDocumentByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetProductDocumentByID;
        PRINT 'Dropped GetProductDocumentByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductDocument_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductDocument_GetByID;
        PRINT 'Dropped spGen__ProductDocument_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductDocument_GetByID

   Description:  Selects record(s) from table 'ProductDocument'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductDocument_GetByID
(
    @ProductDocumentID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ProductDocumentID],[ProductID],[DocumentID],[PairingType],[MimeType],[DocumentTitle],[PublicationDate],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ProductDocument]
    WHERE [ProductDocumentID] = @ProductDocumentID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductDocument_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductDocument_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductDocument_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductDocument_SearchByString;
        PRINT 'Dropped spGen__ProductDocument_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductDocument_SearchByString

   Description:  Selects a record from table 'ProductDocument'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductDocument_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [ProductDocumentID],[ProductID],[DocumentID],[PairingType],[MimeType],[DocumentTitle],[PublicationDate],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ProductDocument]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductDocument_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductDocument_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductDocument_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductDocument_Delete;
        PRINT 'Dropped spGen__ProductDocument_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductDocument_Delete

   Description:  Deletes a record from table 'ProductDocument'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductDocument_Delete
(
    @ProductDocumentID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ProductDocument]
    WHERE [ProductDocumentID] = @ProductDocumentID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductDocument_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductDocument_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductDocument_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductDocument_Save;
        PRINT 'Dropped spGen__ProductDocument_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductDocument_Save

   Description:  Updates or Deletes a record In table 'ProductDocument'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductDocument_Save
(
    @ErrText varchar(4000) output,
    @ProductDocumentID uniqueidentifier output,
    @ProductID uniqueidentifier,
    @DocumentID uniqueidentifier,
    @PairingType nvarchar(100),
    @MimeType varchar(50),
    @DocumentTitle varchar(256),
    @PublicationDate datetime
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ProductDocumentID = '00000000-0000-0000-0000-000000000000' SET @ProductDocumentID = NULL
    IF @ProductDocumentID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ProductDocumentID = NewID()

                    INSERT
                    INTO [ProductDocument]
                    (
                        [ProductDocumentID],
                        [ProductID],
                        [DocumentID],
                        [PairingType],
                        [MimeType],
                        [DocumentTitle],
                        [PublicationDate],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @ProductDocumentID,
                        @ProductID,
                        @DocumentID,
                        @PairingType,
                        @MimeType,
                        @DocumentTitle,
                        @PublicationDate,
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
                    UPDATE [ProductDocument]
                    SET
                    [ProductID] = @ProductID,
                    [DocumentID] = @DocumentID,
                    [PairingType] = @PairingType,
                    [MimeType] = @MimeType,
                    [DocumentTitle] = @DocumentTitle,
                    [PublicationDate] = @PublicationDate,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [ProductDocumentID] = @ProductDocumentID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductDocument_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductDocument_Save Error on Creation'
GO




