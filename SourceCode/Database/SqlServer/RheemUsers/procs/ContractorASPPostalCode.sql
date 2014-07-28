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
   Get rid of obsolete InsertContractorASPPostalCode
   Get rid of obsolete UpdateContractorASPPostalCode
   Get rid of obsolete DeleteContractorASPPostalCode
   Get rid of obsolete SearchContractorASPPostalCodeByString
   Get rid of obsolete GetContractorASPPostalCodeByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorASPPostalCode') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertContractorASPPostalCode;
        PRINT 'Dropped InsertContractorASPPostalCode'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorASPPostalCode') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateContractorASPPostalCode;
        PRINT 'Dropped UpdateContractorASPPostalCode'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorASPPostalCode') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteContractorASPPostalCode;
        PRINT 'Dropped DeleteContractorASPPostalCode'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorASPPostalCodeByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchContractorASPPostalCodeByString;
        PRINT 'Dropped SearchContractorASPPostalCodeByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorASPPostalCodeByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetContractorASPPostalCodeByID;
        PRINT 'Dropped GetContractorASPPostalCodeByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ContractorASPPostalCode_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ContractorASPPostalCode_GetByID;
        PRINT 'Dropped spGen__ContractorASPPostalCode_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ContractorASPPostalCode_GetByID

   Description:  Selects record(s) from table 'ContractorASPPostalCode'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ContractorASPPostalCode_GetByID
(
    @ContractorASPPostalCodeID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ContractorASPPostalCodeID],[OrganizationID],[PostalCode],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ContractorASPPostalCode]
    WHERE [ContractorASPPostalCodeID] = @ContractorASPPostalCodeID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ContractorASPPostalCode_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ContractorASPPostalCode_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ContractorASPPostalCode_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ContractorASPPostalCode_SearchByString;
        PRINT 'Dropped spGen__ContractorASPPostalCode_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ContractorASPPostalCode_SearchByString

   Description:  Selects a record from table 'ContractorASPPostalCode'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ContractorASPPostalCode_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [ContractorASPPostalCodeID],[OrganizationID],[PostalCode],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ContractorASPPostalCode]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__ContractorASPPostalCode_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ContractorASPPostalCode_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ContractorASPPostalCode_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ContractorASPPostalCode_Delete;
        PRINT 'Dropped spGen__ContractorASPPostalCode_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ContractorASPPostalCode_Delete

   Description:  Deletes a record from table 'ContractorASPPostalCode'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ContractorASPPostalCode_Delete
(
    @ContractorASPPostalCodeID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ContractorASPPostalCode]
    WHERE [ContractorASPPostalCodeID] = @ContractorASPPostalCodeID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ContractorASPPostalCode_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ContractorASPPostalCode_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ContractorASPPostalCode_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ContractorASPPostalCode_Save;
        PRINT 'Dropped spGen__ContractorASPPostalCode_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ContractorASPPostalCode_Save

   Description:  Updates or Deletes a record In table 'ContractorASPPostalCode'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ContractorASPPostalCode_Save
(
    @ErrText varchar(4000) output,
    @ContractorASPPostalCodeID uniqueidentifier output,
    @OrganizationID uniqueidentifier,
    @PostalCode varchar(50)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ContractorASPPostalCodeID = '00000000-0000-0000-0000-000000000000' SET @ContractorASPPostalCodeID = NULL
    IF @ContractorASPPostalCodeID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ContractorASPPostalCodeID = NewID()

                    INSERT
                    INTO [ContractorASPPostalCode]
                    (
                        [ContractorASPPostalCodeID],
                        [OrganizationID],
                        [PostalCode],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @ContractorASPPostalCodeID,
                        @OrganizationID,
                        @PostalCode,
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
                    UPDATE [ContractorASPPostalCode]
                    SET
                    [OrganizationID] = @OrganizationID,
                    [PostalCode] = @PostalCode,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [ContractorASPPostalCodeID] = @ContractorASPPostalCodeID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ContractorASPPostalCode_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ContractorASPPostalCode_Save Error on Creation'
GO




