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
USE [RheemEvents]

/* ------------------------------------------------------------
   Get rid of obsolete InsertRheemEventBudget
   Get rid of obsolete UpdateRheemEventBudget
   Get rid of obsolete DeleteRheemEventBudget
   Get rid of obsolete SearchRheemEventBudgetByString
   Get rid of obsolete GetRheemEventBudgetByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertRheemEventBudget') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertRheemEventBudget;
        PRINT 'Dropped InsertRheemEventBudget'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateRheemEventBudget') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateRheemEventBudget;
        PRINT 'Dropped UpdateRheemEventBudget'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteRheemEventBudget') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteRheemEventBudget;
        PRINT 'Dropped DeleteRheemEventBudget'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchRheemEventBudgetByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchRheemEventBudgetByString;
        PRINT 'Dropped SearchRheemEventBudgetByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetRheemEventBudgetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetRheemEventBudgetByID;
        PRINT 'Dropped GetRheemEventBudgetByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__RheemEventBudget_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__RheemEventBudget_GetByID;
        PRINT 'Dropped spGen__RheemEventBudget_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__RheemEventBudget_GetByID

   Description:  Selects record(s) from table 'RheemEventBudget'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__RheemEventBudget_GetByID
(
    @RheemEventBudgetID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [RheemEventBudgetID],[RheemEventID],[GeneralLedgerCode],[Description],[CostInDollars]
    FROM [RheemEventBudget]
    WHERE [RheemEventBudgetID] = @RheemEventBudgetID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__RheemEventBudget_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__RheemEventBudget_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__RheemEventBudget_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__RheemEventBudget_SearchByString;
        PRINT 'Dropped spGen__RheemEventBudget_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__RheemEventBudget_SearchByString

   Description:  Selects a record from table 'RheemEventBudget'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__RheemEventBudget_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [RheemEventBudgetID],[RheemEventID],[GeneralLedgerCode],[Description],[CostInDollars]
    FROM [RheemEventBudget]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__RheemEventBudget_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__RheemEventBudget_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__RheemEventBudget_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__RheemEventBudget_Delete;
        PRINT 'Dropped spGen__RheemEventBudget_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__RheemEventBudget_Delete

   Description:  Deletes a record from table 'RheemEventBudget'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__RheemEventBudget_Delete
(
    @RheemEventBudgetID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [RheemEventBudget]
    WHERE [RheemEventBudgetID] = @RheemEventBudgetID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__RheemEventBudget_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__RheemEventBudget_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__RheemEventBudget_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__RheemEventBudget_Save;
        PRINT 'Dropped spGen__RheemEventBudget_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__RheemEventBudget_Save

   Description:  Updates or Deletes a record In table 'RheemEventBudget'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__RheemEventBudget_Save
(
    @ErrText varchar(4000) output,
    @RheemEventBudgetID uniqueidentifier output,
    @RheemEventID uniqueidentifier,
    @GeneralLedgerCode varchar(50),
    @Description varchar(400),
    @CostInDollars float
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @RheemEventBudgetID = '00000000-0000-0000-0000-000000000000' SET @RheemEventBudgetID = NULL
    IF @RheemEventBudgetID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @RheemEventBudgetID = NewID()

                    INSERT
                    INTO [RheemEventBudget]
                    (
                        [RheemEventBudgetID],
                        [RheemEventID],
                        [GeneralLedgerCode],
                        [Description],
                        [CostInDollars]
                    )
                    VALUES
                    (
                        @RheemEventBudgetID,
                        @RheemEventID,
                        @GeneralLedgerCode,
                        @Description,
                        @CostInDollars
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
                    UPDATE [RheemEventBudget]
                    SET
                    [RheemEventID] = @RheemEventID,
                    [GeneralLedgerCode] = @GeneralLedgerCode,
                    [Description] = @Description,
                    [CostInDollars] = @CostInDollars
                    WHERE [RheemEventBudgetID] = @RheemEventBudgetID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__RheemEventBudget_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__RheemEventBudget_Save Error on Creation'
GO




