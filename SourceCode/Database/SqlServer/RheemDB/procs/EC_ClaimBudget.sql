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
USE [RheemDB]

/* ------------------------------------------------------------
   Get rid of obsolete InsertEC_ClaimBudget
   Get rid of obsolete UpdateEC_ClaimBudget
   Get rid of obsolete DeleteEC_ClaimBudget
   Get rid of obsolete SearchEC_ClaimBudgetByString
   Get rid of obsolete GetEC_ClaimBudgetByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertEC_ClaimBudget') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertEC_ClaimBudget;
        PRINT 'Dropped InsertEC_ClaimBudget'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateEC_ClaimBudget') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateEC_ClaimBudget;
        PRINT 'Dropped UpdateEC_ClaimBudget'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteEC_ClaimBudget') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteEC_ClaimBudget;
        PRINT 'Dropped DeleteEC_ClaimBudget'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchEC_ClaimBudgetByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchEC_ClaimBudgetByString;
        PRINT 'Dropped SearchEC_ClaimBudgetByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetEC_ClaimBudgetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetEC_ClaimBudgetByID;
        PRINT 'Dropped GetEC_ClaimBudgetByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__EC_ClaimBudget_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__EC_ClaimBudget_GetByID;
        PRINT 'Dropped spGen__EC_ClaimBudget_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__EC_ClaimBudget_GetByID

   Description:  Selects record(s) from table 'EC_ClaimBudget'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__EC_ClaimBudget_GetByID
(
    @ClaimBudgetID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ClaimBudgetID],[OrganizationID],[BudgetYear],[ClaimSectionCategoryID],[Totalbudget],[GDPBudget],[TCBudget],[OtherDescription]
    FROM [EC_ClaimBudget]
    WHERE [ClaimBudgetID] = @ClaimBudgetID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__EC_ClaimBudget_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__EC_ClaimBudget_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__EC_ClaimBudget_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__EC_ClaimBudget_SearchByString;
        PRINT 'Dropped spGen__EC_ClaimBudget_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__EC_ClaimBudget_SearchByString

   Description:  Selects a record from table 'EC_ClaimBudget'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__EC_ClaimBudget_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [ClaimBudgetID],[OrganizationID],[BudgetYear],[ClaimSectionCategoryID],[Totalbudget],[GDPBudget],[TCBudget],[OtherDescription]
    FROM [EC_ClaimBudget]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__EC_ClaimBudget_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__EC_ClaimBudget_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__EC_ClaimBudget_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__EC_ClaimBudget_Delete;
        PRINT 'Dropped spGen__EC_ClaimBudget_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__EC_ClaimBudget_Delete

   Description:  Deletes a record from table 'EC_ClaimBudget'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__EC_ClaimBudget_Delete
(
    @ClaimBudgetID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [EC_ClaimBudget]
    WHERE [ClaimBudgetID] = @ClaimBudgetID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__EC_ClaimBudget_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__EC_ClaimBudget_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__EC_ClaimBudget_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__EC_ClaimBudget_Save;
        PRINT 'Dropped spGen__EC_ClaimBudget_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__EC_ClaimBudget_Save

   Description:  Updates or Deletes a record In table 'EC_ClaimBudget'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__EC_ClaimBudget_Save
(
    @ErrText varchar(4000) output,
    @ClaimBudgetID uniqueidentifier output,
    @OrganizationID uniqueidentifier,
    @BudgetYear int,
    @ClaimSectionCategoryID uniqueidentifier,
    @Totalbudget float,
    @GDPBudget bit,
    @TCBudget bit,
    @OtherDescription varchar(50)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ClaimBudgetID = '00000000-0000-0000-0000-000000000000' SET @ClaimBudgetID = NULL
    IF @ClaimBudgetID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ClaimBudgetID = NewID()

                    INSERT
                    INTO [EC_ClaimBudget]
                    (
                        [ClaimBudgetID],
                        [OrganizationID],
                        [BudgetYear],
                        [ClaimSectionCategoryID],
                        [Totalbudget],
                        [GDPBudget],
                        [TCBudget],
                        [OtherDescription]
                    )
                    VALUES
                    (
                        @ClaimBudgetID,
                        @OrganizationID,
                        @BudgetYear,
                        @ClaimSectionCategoryID,
                        @Totalbudget,
                        @GDPBudget,
                        @TCBudget,
                        @OtherDescription
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
                    UPDATE [EC_ClaimBudget]
                    SET
                    [OrganizationID] = @OrganizationID,
                    [BudgetYear] = @BudgetYear,
                    [ClaimSectionCategoryID] = @ClaimSectionCategoryID,
                    [Totalbudget] = @Totalbudget,
                    [GDPBudget] = @GDPBudget,
                    [TCBudget] = @TCBudget,
                    [OtherDescription] = @OtherDescription
                    WHERE [ClaimBudgetID] = @ClaimBudgetID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__EC_ClaimBudget_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__EC_ClaimBudget_Save Error on Creation'
GO




