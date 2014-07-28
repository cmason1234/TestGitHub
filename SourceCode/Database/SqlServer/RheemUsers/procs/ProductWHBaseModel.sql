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
   Get rid of obsolete InsertProductWHBaseModel
   Get rid of obsolete UpdateProductWHBaseModel
   Get rid of obsolete DeleteProductWHBaseModel
   Get rid of obsolete SearchProductWHBaseModelByString
   Get rid of obsolete GetProductWHBaseModelByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertProductWHBaseModel') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertProductWHBaseModel;
        PRINT 'Dropped InsertProductWHBaseModel'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateProductWHBaseModel') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateProductWHBaseModel;
        PRINT 'Dropped UpdateProductWHBaseModel'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteProductWHBaseModel') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteProductWHBaseModel;
        PRINT 'Dropped DeleteProductWHBaseModel'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchProductWHBaseModelByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchProductWHBaseModelByString;
        PRINT 'Dropped SearchProductWHBaseModelByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetProductWHBaseModelByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetProductWHBaseModelByID;
        PRINT 'Dropped GetProductWHBaseModelByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductWHBaseModel_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductWHBaseModel_GetByID;
        PRINT 'Dropped spGen__ProductWHBaseModel_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductWHBaseModel_GetByID

   Description:  Selects record(s) from table 'ProductWHBaseModel'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductWHBaseModel_GetByID
(
    @ProductWHBaseModelID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ProductWHBaseModelID],[BaseModel],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ProductWHBaseModel]
    WHERE [ProductWHBaseModelID] = @ProductWHBaseModelID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductWHBaseModel_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductWHBaseModel_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductWHBaseModel_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductWHBaseModel_SearchByString;
        PRINT 'Dropped spGen__ProductWHBaseModel_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductWHBaseModel_SearchByString

   Description:  Selects a record from table 'ProductWHBaseModel'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductWHBaseModel_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [ProductWHBaseModelID],[BaseModel],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ProductWHBaseModel]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductWHBaseModel_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductWHBaseModel_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductWHBaseModel_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductWHBaseModel_Delete;
        PRINT 'Dropped spGen__ProductWHBaseModel_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductWHBaseModel_Delete

   Description:  Deletes a record from table 'ProductWHBaseModel'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductWHBaseModel_Delete
(
    @ProductWHBaseModelID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ProductWHBaseModel]
    WHERE [ProductWHBaseModelID] = @ProductWHBaseModelID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductWHBaseModel_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductWHBaseModel_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductWHBaseModel_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductWHBaseModel_Save;
        PRINT 'Dropped spGen__ProductWHBaseModel_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductWHBaseModel_Save

   Description:  Updates or Deletes a record In table 'ProductWHBaseModel'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductWHBaseModel_Save
(
    @ErrText varchar(4000) output,
    @ProductWHBaseModelID uniqueidentifier output,
    @BaseModel varchar(50)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ProductWHBaseModelID = '00000000-0000-0000-0000-000000000000' SET @ProductWHBaseModelID = NULL
    IF @ProductWHBaseModelID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ProductWHBaseModelID = NewID()

                    INSERT
                    INTO [ProductWHBaseModel]
                    (
                        [ProductWHBaseModelID],
                        [BaseModel],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @ProductWHBaseModelID,
                        @BaseModel,
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
                    UPDATE [ProductWHBaseModel]
                    SET
                    [BaseModel] = @BaseModel,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [ProductWHBaseModelID] = @ProductWHBaseModelID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductWHBaseModel_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductWHBaseModel_Save Error on Creation'
GO




