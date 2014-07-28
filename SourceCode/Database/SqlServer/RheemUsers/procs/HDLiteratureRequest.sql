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
   Get rid of obsolete InsertHDLiteratureRequest
   Get rid of obsolete UpdateHDLiteratureRequest
   Get rid of obsolete DeleteHDLiteratureRequest
   Get rid of obsolete SearchHDLiteratureRequestByString
   Get rid of obsolete GetHDLiteratureRequestByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertHDLiteratureRequest') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertHDLiteratureRequest;
        PRINT 'Dropped InsertHDLiteratureRequest'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateHDLiteratureRequest') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateHDLiteratureRequest;
        PRINT 'Dropped UpdateHDLiteratureRequest'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteHDLiteratureRequest') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteHDLiteratureRequest;
        PRINT 'Dropped DeleteHDLiteratureRequest'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchHDLiteratureRequestByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchHDLiteratureRequestByString;
        PRINT 'Dropped SearchHDLiteratureRequestByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetHDLiteratureRequestByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetHDLiteratureRequestByID;
        PRINT 'Dropped GetHDLiteratureRequestByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDLiteratureRequest_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDLiteratureRequest_GetByID;
        PRINT 'Dropped spGen__HDLiteratureRequest_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDLiteratureRequest_GetByID

   Description:  Selects record(s) from table 'HDLiteratureRequest'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDLiteratureRequest_GetByID
(
    @HDLiteratureRequestID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [HDLiteratureRequestID],[OrderNumber],[BatchNumber],[OrderDate],[PersonID],[Name],[AddressLine1],[AddressLine2],[City],[State],[Zip],[Phone],[Email],[CompanyName],[ShipName],[ShipAddressLine1],[ShipAddressLine2],[ShipCity],[ShipState],[ShipZip],[NumberOfBundles],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HDLiteratureRequest]
    WHERE [HDLiteratureRequestID] = @HDLiteratureRequestID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDLiteratureRequest_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__HDLiteratureRequest_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDLiteratureRequest_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDLiteratureRequest_SearchByString;
        PRINT 'Dropped spGen__HDLiteratureRequest_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDLiteratureRequest_SearchByString

   Description:  Selects a record from table 'HDLiteratureRequest'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDLiteratureRequest_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [HDLiteratureRequestID],[OrderNumber],[BatchNumber],[OrderDate],[PersonID],[Name],[AddressLine1],[AddressLine2],[City],[State],[Zip],[Phone],[Email],[CompanyName],[ShipName],[ShipAddressLine1],[ShipAddressLine2],[ShipCity],[ShipState],[ShipZip],[NumberOfBundles],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HDLiteratureRequest]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDLiteratureRequest_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__HDLiteratureRequest_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDLiteratureRequest_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDLiteratureRequest_Delete;
        PRINT 'Dropped spGen__HDLiteratureRequest_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDLiteratureRequest_Delete

   Description:  Deletes a record from table 'HDLiteratureRequest'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDLiteratureRequest_Delete
(
    @HDLiteratureRequestID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [HDLiteratureRequest]
    WHERE [HDLiteratureRequestID] = @HDLiteratureRequestID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDLiteratureRequest_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__HDLiteratureRequest_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDLiteratureRequest_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDLiteratureRequest_Save;
        PRINT 'Dropped spGen__HDLiteratureRequest_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDLiteratureRequest_Save

   Description:  Updates or Deletes a record In table 'HDLiteratureRequest'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDLiteratureRequest_Save
(
    @ErrText varchar(4000) output,
    @HDLiteratureRequestID uniqueidentifier output,
    @OrderNumber int,
    @BatchNumber int,
    @OrderDate datetime,
    @PersonID uniqueidentifier,
    @Name varchar(100),
    @AddressLine1 varchar(100),
    @AddressLine2 varchar(100),
    @City varchar(100),
    @State varchar(2),
    @Zip varchar(50),
    @Phone varchar(50),
    @Email varchar(100),
    @CompanyName varchar(128),
    @ShipName varchar(100),
    @ShipAddressLine1 varchar(100),
    @ShipAddressLine2 varchar(100),
    @ShipCity varchar(100),
    @ShipState varchar(2),
    @ShipZip varchar(50),
    @NumberOfBundles int
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @HDLiteratureRequestID = '00000000-0000-0000-0000-000000000000' SET @HDLiteratureRequestID = NULL
    IF @HDLiteratureRequestID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @HDLiteratureRequestID = NewID()

                    INSERT
                    INTO [HDLiteratureRequest]
                    (
                        [HDLiteratureRequestID],
                        [OrderNumber],
                        [BatchNumber],
                        [OrderDate],
                        [PersonID],
                        [Name],
                        [AddressLine1],
                        [AddressLine2],
                        [City],
                        [State],
                        [Zip],
                        [Phone],
                        [Email],
                        [CompanyName],
                        [ShipName],
                        [ShipAddressLine1],
                        [ShipAddressLine2],
                        [ShipCity],
                        [ShipState],
                        [ShipZip],
                        [NumberOfBundles],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @HDLiteratureRequestID,
                        @OrderNumber,
                        @BatchNumber,
                        @OrderDate,
                        @PersonID,
                        @Name,
                        @AddressLine1,
                        @AddressLine2,
                        @City,
                        @State,
                        @Zip,
                        @Phone,
                        @Email,
                        @CompanyName,
                        @ShipName,
                        @ShipAddressLine1,
                        @ShipAddressLine2,
                        @ShipCity,
                        @ShipState,
                        @ShipZip,
                        @NumberOfBundles,
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
                    UPDATE [HDLiteratureRequest]
                    SET
                    [OrderNumber] = @OrderNumber,
                    [BatchNumber] = @BatchNumber,
                    [OrderDate] = @OrderDate,
                    [PersonID] = @PersonID,
                    [Name] = @Name,
                    [AddressLine1] = @AddressLine1,
                    [AddressLine2] = @AddressLine2,
                    [City] = @City,
                    [State] = @State,
                    [Zip] = @Zip,
                    [Phone] = @Phone,
                    [Email] = @Email,
                    [CompanyName] = @CompanyName,
                    [ShipName] = @ShipName,
                    [ShipAddressLine1] = @ShipAddressLine1,
                    [ShipAddressLine2] = @ShipAddressLine2,
                    [ShipCity] = @ShipCity,
                    [ShipState] = @ShipState,
                    [ShipZip] = @ShipZip,
                    [NumberOfBundles] = @NumberOfBundles,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [HDLiteratureRequestID] = @HDLiteratureRequestID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDLiteratureRequest_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__HDLiteratureRequest_Save Error on Creation'
GO




