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
   Get rid of obsolete InsertDistributorCatalogPricing
   Get rid of obsolete UpdateDistributorCatalogPricing
   Get rid of obsolete DeleteDistributorCatalogPricing
   Get rid of obsolete SearchDistributorCatalogPricingByString
   Get rid of obsolete GetDistributorCatalogPricingByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertDistributorCatalogPricing') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertDistributorCatalogPricing;
        PRINT 'Dropped InsertDistributorCatalogPricing'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateDistributorCatalogPricing') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateDistributorCatalogPricing;
        PRINT 'Dropped UpdateDistributorCatalogPricing'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteDistributorCatalogPricing') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteDistributorCatalogPricing;
        PRINT 'Dropped DeleteDistributorCatalogPricing'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchDistributorCatalogPricingByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchDistributorCatalogPricingByString;
        PRINT 'Dropped SearchDistributorCatalogPricingByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetDistributorCatalogPricingByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetDistributorCatalogPricingByID;
        PRINT 'Dropped GetDistributorCatalogPricingByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__DistributorCatalogPricing_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__DistributorCatalogPricing_GetByID;
        PRINT 'Dropped spGen__DistributorCatalogPricing_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__DistributorCatalogPricing_GetByID

   Description:  Selects record(s) from table 'DistributorCatalogPricing'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__DistributorCatalogPricing_GetByID
(
    @DistributorCatalogPricingID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [DistributorCatalogPricingID],[DistributorCatalogPricingNamesID],[ProductModelID],[ModelCost],[IsActive],[CreateDateTime__Gen],[UpdateDateTime__Gen],[Remark],[UseRemark]
    FROM [DistributorCatalogPricing]
    WHERE [DistributorCatalogPricingID] = @DistributorCatalogPricingID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__DistributorCatalogPricing_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__DistributorCatalogPricing_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__DistributorCatalogPricing_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__DistributorCatalogPricing_SearchByString;
        PRINT 'Dropped spGen__DistributorCatalogPricing_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__DistributorCatalogPricing_SearchByString

   Description:  Selects a record from table 'DistributorCatalogPricing'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__DistributorCatalogPricing_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [DistributorCatalogPricingID],[DistributorCatalogPricingNamesID],[ProductModelID],[ModelCost],[IsActive],[CreateDateTime__Gen],[UpdateDateTime__Gen],[Remark],[UseRemark]
    FROM [DistributorCatalogPricing]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__DistributorCatalogPricing_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__DistributorCatalogPricing_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__DistributorCatalogPricing_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__DistributorCatalogPricing_Delete;
        PRINT 'Dropped spGen__DistributorCatalogPricing_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__DistributorCatalogPricing_Delete

   Description:  Deletes a record from table 'DistributorCatalogPricing'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__DistributorCatalogPricing_Delete
(
    @DistributorCatalogPricingID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [DistributorCatalogPricing]
    WHERE [DistributorCatalogPricingID] = @DistributorCatalogPricingID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__DistributorCatalogPricing_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__DistributorCatalogPricing_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__DistributorCatalogPricing_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__DistributorCatalogPricing_Save;
        PRINT 'Dropped spGen__DistributorCatalogPricing_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__DistributorCatalogPricing_Save

   Description:  Updates or Deletes a record In table 'DistributorCatalogPricing'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__DistributorCatalogPricing_Save
(
    @ErrText varchar(4000) output,
    @DistributorCatalogPricingID uniqueidentifier output,
    @DistributorCatalogPricingNamesID uniqueidentifier,
    @ProductModelID uniqueidentifier,
    @ModelCost float,
    @IsActive bit,
    @Remark varchar(20),
    @UseRemark bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @DistributorCatalogPricingID = '00000000-0000-0000-0000-000000000000' SET @DistributorCatalogPricingID = NULL
    IF @DistributorCatalogPricingID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @DistributorCatalogPricingID = NewID()

                    INSERT
                    INTO [DistributorCatalogPricing]
                    (
                        [DistributorCatalogPricingID],
                        [DistributorCatalogPricingNamesID],
                        [ProductModelID],
                        [ModelCost],
                        [IsActive],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen],
                        [Remark],
                        [UseRemark]
                    )
                    VALUES
                    (
                        @DistributorCatalogPricingID,
                        @DistributorCatalogPricingNamesID,
                        @ProductModelID,
                        @ModelCost,
                        @IsActive,
                        SYSDATETIME(),
                        SYSDATETIME(),
                        @Remark,
                        @UseRemark
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
                    UPDATE [DistributorCatalogPricing]
                    SET
                    [DistributorCatalogPricingNamesID] = @DistributorCatalogPricingNamesID,
                    [ProductModelID] = @ProductModelID,
                    [ModelCost] = @ModelCost,
                    [IsActive] = @IsActive,
                    [UpdateDateTime__Gen] = SYSDATETIME(),
                    [Remark] = @Remark,
                    [UseRemark] = @UseRemark
                    WHERE [DistributorCatalogPricingID] = @DistributorCatalogPricingID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__DistributorCatalogPricing_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__DistributorCatalogPricing_Save Error on Creation'
GO




