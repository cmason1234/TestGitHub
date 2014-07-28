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
   Get rid of obsolete InsertContractorFactoryDirect
   Get rid of obsolete UpdateContractorFactoryDirect
   Get rid of obsolete DeleteContractorFactoryDirect
   Get rid of obsolete SearchContractorFactoryDirectByString
   Get rid of obsolete GetContractorFactoryDirectByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorFactoryDirect') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertContractorFactoryDirect;
        PRINT 'Dropped InsertContractorFactoryDirect'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorFactoryDirect') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateContractorFactoryDirect;
        PRINT 'Dropped UpdateContractorFactoryDirect'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorFactoryDirect') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteContractorFactoryDirect;
        PRINT 'Dropped DeleteContractorFactoryDirect'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorFactoryDirectByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchContractorFactoryDirectByString;
        PRINT 'Dropped SearchContractorFactoryDirectByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorFactoryDirectByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetContractorFactoryDirectByID;
        PRINT 'Dropped GetContractorFactoryDirectByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ContractorFactoryDirect_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ContractorFactoryDirect_GetByID;
        PRINT 'Dropped spGen__ContractorFactoryDirect_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ContractorFactoryDirect_GetByID

   Description:  Selects record(s) from table 'ContractorFactoryDirect'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ContractorFactoryDirect_GetByID
(
    @ContractorFactoryDirectID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ContractorFactoryDirectID],[OrganizationID],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ContractorFactoryDirect]
    WHERE [ContractorFactoryDirectID] = @ContractorFactoryDirectID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ContractorFactoryDirect_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ContractorFactoryDirect_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ContractorFactoryDirect_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ContractorFactoryDirect_SearchByString;
        PRINT 'Dropped spGen__ContractorFactoryDirect_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ContractorFactoryDirect_SearchByString

   Description:  Selects a record from table 'ContractorFactoryDirect'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ContractorFactoryDirect_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [ContractorFactoryDirectID],[OrganizationID],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ContractorFactoryDirect]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__ContractorFactoryDirect_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ContractorFactoryDirect_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ContractorFactoryDirect_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ContractorFactoryDirect_Delete;
        PRINT 'Dropped spGen__ContractorFactoryDirect_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ContractorFactoryDirect_Delete

   Description:  Deletes a record from table 'ContractorFactoryDirect'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ContractorFactoryDirect_Delete
(
    @ContractorFactoryDirectID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ContractorFactoryDirect]
    WHERE [ContractorFactoryDirectID] = @ContractorFactoryDirectID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ContractorFactoryDirect_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ContractorFactoryDirect_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ContractorFactoryDirect_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ContractorFactoryDirect_Save;
        PRINT 'Dropped spGen__ContractorFactoryDirect_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ContractorFactoryDirect_Save

   Description:  Updates or Deletes a record In table 'ContractorFactoryDirect'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ContractorFactoryDirect_Save
(
    @ErrText varchar(4000) output,
    @ContractorFactoryDirectID uniqueidentifier output,
    @OrganizationID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ContractorFactoryDirectID = '00000000-0000-0000-0000-000000000000' SET @ContractorFactoryDirectID = NULL
    IF @ContractorFactoryDirectID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ContractorFactoryDirectID = NewID()

                    INSERT
                    INTO [ContractorFactoryDirect]
                    (
                        [ContractorFactoryDirectID],
                        [OrganizationID],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @ContractorFactoryDirectID,
                        @OrganizationID,
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
                    UPDATE [ContractorFactoryDirect]
                    SET
                    [OrganizationID] = @OrganizationID,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [ContractorFactoryDirectID] = @ContractorFactoryDirectID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ContractorFactoryDirect_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ContractorFactoryDirect_Save Error on Creation'
GO




