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
   Get rid of obsolete InsertProductWHBTU
   Get rid of obsolete UpdateProductWHBTU
   Get rid of obsolete DeleteProductWHBTU
   Get rid of obsolete SearchProductWHBTUByString
   Get rid of obsolete GetProductWHBTUByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertProductWHBTU') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertProductWHBTU;
        PRINT 'Dropped InsertProductWHBTU'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateProductWHBTU') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateProductWHBTU;
        PRINT 'Dropped UpdateProductWHBTU'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteProductWHBTU') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteProductWHBTU;
        PRINT 'Dropped DeleteProductWHBTU'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchProductWHBTUByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchProductWHBTUByString;
        PRINT 'Dropped SearchProductWHBTUByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetProductWHBTUByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetProductWHBTUByID;
        PRINT 'Dropped GetProductWHBTUByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductWHBTU_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductWHBTU_GetByID;
        PRINT 'Dropped spGen__ProductWHBTU_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductWHBTU_GetByID

   Description:  Selects record(s) from table 'ProductWHBTU'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductWHBTU_GetByID
(
    @ProductWHBTUID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ProductWHBTUID],[BTU],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ProductWHBTU]
    WHERE [ProductWHBTUID] = @ProductWHBTUID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductWHBTU_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductWHBTU_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductWHBTU_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductWHBTU_SearchByString;
        PRINT 'Dropped spGen__ProductWHBTU_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductWHBTU_SearchByString

   Description:  Selects a record from table 'ProductWHBTU'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductWHBTU_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [ProductWHBTUID],[BTU],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ProductWHBTU]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductWHBTU_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductWHBTU_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductWHBTU_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductWHBTU_Delete;
        PRINT 'Dropped spGen__ProductWHBTU_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductWHBTU_Delete

   Description:  Deletes a record from table 'ProductWHBTU'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductWHBTU_Delete
(
    @ProductWHBTUID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ProductWHBTU]
    WHERE [ProductWHBTUID] = @ProductWHBTUID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductWHBTU_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductWHBTU_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductWHBTU_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductWHBTU_Save;
        PRINT 'Dropped spGen__ProductWHBTU_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductWHBTU_Save

   Description:  Updates or Deletes a record In table 'ProductWHBTU'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductWHBTU_Save
(
    @ErrText varchar(4000) output,
    @ProductWHBTUID uniqueidentifier output,
    @BTU int
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ProductWHBTUID = '00000000-0000-0000-0000-000000000000' SET @ProductWHBTUID = NULL
    IF @ProductWHBTUID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ProductWHBTUID = NewID()

                    INSERT
                    INTO [ProductWHBTU]
                    (
                        [ProductWHBTUID],
                        [BTU],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @ProductWHBTUID,
                        @BTU,
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
                    UPDATE [ProductWHBTU]
                    SET
                    [BTU] = @BTU,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [ProductWHBTUID] = @ProductWHBTUID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductWHBTU_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductWHBTU_Save Error on Creation'
GO




