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
   Get rid of obsolete InsertProductGroup
   Get rid of obsolete UpdateProductGroup
   Get rid of obsolete DeleteProductGroup
   Get rid of obsolete SearchProductGroupByString
   Get rid of obsolete GetProductGroupByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertProductGroup') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertProductGroup;
        PRINT 'Dropped InsertProductGroup'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateProductGroup') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateProductGroup;
        PRINT 'Dropped UpdateProductGroup'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteProductGroup') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteProductGroup;
        PRINT 'Dropped DeleteProductGroup'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchProductGroupByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchProductGroupByString;
        PRINT 'Dropped SearchProductGroupByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetProductGroupByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetProductGroupByID;
        PRINT 'Dropped GetProductGroupByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductGroup_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductGroup_GetByID;
        PRINT 'Dropped spGen__ProductGroup_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductGroup_GetByID

   Description:  Selects record(s) from table 'ProductGroup'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductGroup_GetByID
(
    @ProductGroupID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ProductGroupID],[GroupName],[GroupSpecificationHTML],[GroupFeaturesHTML],[AC],[WH],[GroupWarrantyHTML],[ProductCategoryID],[SequenceNumber],[CreateDateTime__Gen],[UpdateDateTime__Gen],[BrandID],[UseModelPage],[MetaTitle],[MetaDescription],[DivisionID],[HeroTitle],[HeroSubTitle],[ProductGroupInformation]
    FROM [ProductGroup]
    WHERE [ProductGroupID] = @ProductGroupID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductGroup_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductGroup_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductGroup_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductGroup_SearchByString;
        PRINT 'Dropped spGen__ProductGroup_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductGroup_SearchByString

   Description:  Selects a record from table 'ProductGroup'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductGroup_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [ProductGroupID],[GroupName],[GroupSpecificationHTML],[GroupFeaturesHTML],[AC],[WH],[GroupWarrantyHTML],[ProductCategoryID],[SequenceNumber],[CreateDateTime__Gen],[UpdateDateTime__Gen],[BrandID],[UseModelPage],[MetaTitle],[MetaDescription],[DivisionID],[HeroTitle],[HeroSubTitle],[ProductGroupInformation]
    FROM [ProductGroup]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductGroup_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductGroup_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductGroup_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductGroup_Delete;
        PRINT 'Dropped spGen__ProductGroup_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductGroup_Delete

   Description:  Deletes a record from table 'ProductGroup'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductGroup_Delete
(
    @ProductGroupID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ProductGroup]
    WHERE [ProductGroupID] = @ProductGroupID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductGroup_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductGroup_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ProductGroup_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ProductGroup_Save;
        PRINT 'Dropped spGen__ProductGroup_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ProductGroup_Save

   Description:  Updates or Deletes a record In table 'ProductGroup'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ProductGroup_Save
(
    @ErrText varchar(4000) output,
    @ProductGroupID uniqueidentifier output,
    @GroupName varchar(256),
    @GroupSpecificationHTML text,
    @GroupFeaturesHTML text,
    @AC bit,
    @WH bit,
    @GroupWarrantyHTML text,
    @ProductCategoryID uniqueidentifier,
    @SequenceNumber int,
    @BrandID uniqueidentifier,
    @UseModelPage bit,
    @MetaTitle varchar(150),
    @MetaDescription varchar(512),
    @DivisionID uniqueidentifier,
    @HeroTitle varchar(150),
    @HeroSubTitle varchar(150),
    @ProductGroupInformation text
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ProductGroupID = '00000000-0000-0000-0000-000000000000' SET @ProductGroupID = NULL
    IF @ProductGroupID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ProductGroupID = NewID()

                    INSERT
                    INTO [ProductGroup]
                    (
                        [ProductGroupID],
                        [GroupName],
                        [GroupSpecificationHTML],
                        [GroupFeaturesHTML],
                        [AC],
                        [WH],
                        [GroupWarrantyHTML],
                        [ProductCategoryID],
                        [SequenceNumber],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen],
                        [BrandID],
                        [UseModelPage],
                        [MetaTitle],
                        [MetaDescription],
                        [DivisionID],
                        [HeroTitle],
                        [HeroSubTitle],
                        [ProductGroupInformation]
                    )
                    VALUES
                    (
                        @ProductGroupID,
                        @GroupName,
                        @GroupSpecificationHTML,
                        @GroupFeaturesHTML,
                        @AC,
                        @WH,
                        @GroupWarrantyHTML,
                        @ProductCategoryID,
                        @SequenceNumber,
                        SYSDATETIME(),
                        SYSDATETIME(),
                        @BrandID,
                        @UseModelPage,
                        @MetaTitle,
                        @MetaDescription,
                        @DivisionID,
                        @HeroTitle,
                        @HeroSubTitle,
                        @ProductGroupInformation
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
                    UPDATE [ProductGroup]
                    SET
                    [GroupName] = @GroupName,
                    [GroupSpecificationHTML] = @GroupSpecificationHTML,
                    [GroupFeaturesHTML] = @GroupFeaturesHTML,
                    [AC] = @AC,
                    [WH] = @WH,
                    [GroupWarrantyHTML] = @GroupWarrantyHTML,
                    [ProductCategoryID] = @ProductCategoryID,
                    [SequenceNumber] = @SequenceNumber,
                    [UpdateDateTime__Gen] = SYSDATETIME(),
                    [BrandID] = @BrandID,
                    [UseModelPage] = @UseModelPage,
                    [MetaTitle] = @MetaTitle,
                    [MetaDescription] = @MetaDescription,
                    [DivisionID] = @DivisionID,
                    [HeroTitle] = @HeroTitle,
                    [HeroSubTitle] = @HeroSubTitle,
                    [ProductGroupInformation] = @ProductGroupInformation
                    WHERE [ProductGroupID] = @ProductGroupID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ProductGroup_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ProductGroup_Save Error on Creation'
GO




