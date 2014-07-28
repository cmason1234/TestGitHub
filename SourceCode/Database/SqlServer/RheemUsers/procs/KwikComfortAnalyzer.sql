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
   Get rid of obsolete InsertKwikComfortAnalyzer
   Get rid of obsolete UpdateKwikComfortAnalyzer
   Get rid of obsolete DeleteKwikComfortAnalyzer
   Get rid of obsolete SearchKwikComfortAnalyzerByString
   Get rid of obsolete GetKwikComfortAnalyzerByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertKwikComfortAnalyzer') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertKwikComfortAnalyzer;
        PRINT 'Dropped InsertKwikComfortAnalyzer'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateKwikComfortAnalyzer') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateKwikComfortAnalyzer;
        PRINT 'Dropped UpdateKwikComfortAnalyzer'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteKwikComfortAnalyzer') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteKwikComfortAnalyzer;
        PRINT 'Dropped DeleteKwikComfortAnalyzer'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchKwikComfortAnalyzerByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchKwikComfortAnalyzerByString;
        PRINT 'Dropped SearchKwikComfortAnalyzerByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetKwikComfortAnalyzerByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetKwikComfortAnalyzerByID;
        PRINT 'Dropped GetKwikComfortAnalyzerByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__KwikComfortAnalyzer_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__KwikComfortAnalyzer_GetByID;
        PRINT 'Dropped spGen__KwikComfortAnalyzer_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__KwikComfortAnalyzer_GetByID

   Description:  Selects record(s) from table 'KwikComfortAnalyzer'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__KwikComfortAnalyzer_GetByID
(
    @KwikComfortAnalyzerID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [KwikComfortAnalyzerID],[MerchantNumber],[MerchantName],[ClientSpecific],[Address],[City],[State],[Zip],[Phone],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [KwikComfortAnalyzer]
    WHERE [KwikComfortAnalyzerID] = @KwikComfortAnalyzerID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__KwikComfortAnalyzer_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__KwikComfortAnalyzer_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__KwikComfortAnalyzer_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__KwikComfortAnalyzer_SearchByString;
        PRINT 'Dropped spGen__KwikComfortAnalyzer_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__KwikComfortAnalyzer_SearchByString

   Description:  Selects a record from table 'KwikComfortAnalyzer'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__KwikComfortAnalyzer_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [KwikComfortAnalyzerID],[MerchantNumber],[MerchantName],[ClientSpecific],[Address],[City],[State],[Zip],[Phone],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [KwikComfortAnalyzer]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__KwikComfortAnalyzer_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__KwikComfortAnalyzer_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__KwikComfortAnalyzer_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__KwikComfortAnalyzer_Delete;
        PRINT 'Dropped spGen__KwikComfortAnalyzer_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__KwikComfortAnalyzer_Delete

   Description:  Deletes a record from table 'KwikComfortAnalyzer'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__KwikComfortAnalyzer_Delete
(
    @KwikComfortAnalyzerID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [KwikComfortAnalyzer]
    WHERE [KwikComfortAnalyzerID] = @KwikComfortAnalyzerID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__KwikComfortAnalyzer_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__KwikComfortAnalyzer_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__KwikComfortAnalyzer_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__KwikComfortAnalyzer_Save;
        PRINT 'Dropped spGen__KwikComfortAnalyzer_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__KwikComfortAnalyzer_Save

   Description:  Updates or Deletes a record In table 'KwikComfortAnalyzer'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__KwikComfortAnalyzer_Save
(
    @ErrText varchar(4000) output,
    @KwikComfortAnalyzerID uniqueidentifier output,
    @MerchantNumber varchar(150),
    @MerchantName varchar(150),
    @ClientSpecific varchar(150),
    @Address varchar(150),
    @City varchar(150),
    @State varchar(150),
    @Zip varchar(50),
    @Phone varchar(30)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @KwikComfortAnalyzerID = '00000000-0000-0000-0000-000000000000' SET @KwikComfortAnalyzerID = NULL
    IF @KwikComfortAnalyzerID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @KwikComfortAnalyzerID = NewID()

                    INSERT
                    INTO [KwikComfortAnalyzer]
                    (
                        [KwikComfortAnalyzerID],
                        [MerchantNumber],
                        [MerchantName],
                        [ClientSpecific],
                        [Address],
                        [City],
                        [State],
                        [Zip],
                        [Phone],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @KwikComfortAnalyzerID,
                        @MerchantNumber,
                        @MerchantName,
                        @ClientSpecific,
                        @Address,
                        @City,
                        @State,
                        @Zip,
                        @Phone,
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
                    UPDATE [KwikComfortAnalyzer]
                    SET
                    [MerchantNumber] = @MerchantNumber,
                    [MerchantName] = @MerchantName,
                    [ClientSpecific] = @ClientSpecific,
                    [Address] = @Address,
                    [City] = @City,
                    [State] = @State,
                    [Zip] = @Zip,
                    [Phone] = @Phone,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [KwikComfortAnalyzerID] = @KwikComfortAnalyzerID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__KwikComfortAnalyzer_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__KwikComfortAnalyzer_Save Error on Creation'
GO




