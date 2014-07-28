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
   Get rid of obsolete InsertItsAllAboutYou
   Get rid of obsolete UpdateItsAllAboutYou
   Get rid of obsolete DeleteItsAllAboutYou
   Get rid of obsolete SearchItsAllAboutYouByString
   Get rid of obsolete GetItsAllAboutYouByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertItsAllAboutYou') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertItsAllAboutYou;
        PRINT 'Dropped InsertItsAllAboutYou'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateItsAllAboutYou') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateItsAllAboutYou;
        PRINT 'Dropped UpdateItsAllAboutYou'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteItsAllAboutYou') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteItsAllAboutYou;
        PRINT 'Dropped DeleteItsAllAboutYou'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchItsAllAboutYouByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchItsAllAboutYouByString;
        PRINT 'Dropped SearchItsAllAboutYouByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetItsAllAboutYouByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetItsAllAboutYouByID;
        PRINT 'Dropped GetItsAllAboutYouByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ItsAllAboutYou_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ItsAllAboutYou_GetByID;
        PRINT 'Dropped spGen__ItsAllAboutYou_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ItsAllAboutYou_GetByID

   Description:  Selects record(s) from table 'ItsAllAboutYou'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ItsAllAboutYou_GetByID
(
    @RequestID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [RequestID],[FirstName],[LastName],[Company],[emailAddress],[Phone],[Address],[City],[State],[PostalCode],[Message],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ItsAllAboutYou]
    WHERE [RequestID] = @RequestID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ItsAllAboutYou_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ItsAllAboutYou_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ItsAllAboutYou_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ItsAllAboutYou_SearchByString;
        PRINT 'Dropped spGen__ItsAllAboutYou_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ItsAllAboutYou_SearchByString

   Description:  Selects a record from table 'ItsAllAboutYou'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ItsAllAboutYou_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [RequestID],[FirstName],[LastName],[Company],[emailAddress],[Phone],[Address],[City],[State],[PostalCode],[Message],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ItsAllAboutYou]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__ItsAllAboutYou_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ItsAllAboutYou_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ItsAllAboutYou_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ItsAllAboutYou_Delete;
        PRINT 'Dropped spGen__ItsAllAboutYou_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ItsAllAboutYou_Delete

   Description:  Deletes a record from table 'ItsAllAboutYou'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ItsAllAboutYou_Delete
(
    @RequestID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ItsAllAboutYou]
    WHERE [RequestID] = @RequestID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ItsAllAboutYou_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ItsAllAboutYou_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ItsAllAboutYou_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ItsAllAboutYou_Save;
        PRINT 'Dropped spGen__ItsAllAboutYou_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ItsAllAboutYou_Save

   Description:  Updates or Deletes a record In table 'ItsAllAboutYou'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ItsAllAboutYou_Save
(
    @ErrText varchar(4000) output,
    @RequestID uniqueidentifier output,
    @FirstName varchar(50),
    @LastName varchar(50),
    @Company varchar(50),
    @emailAddress varchar(50),
    @Phone varchar(50),
    @Address varchar(50),
    @City varchar(50),
    @State varchar(2),
    @PostalCode varchar(50),
    @Message text
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @RequestID = '00000000-0000-0000-0000-000000000000' SET @RequestID = NULL
    IF @RequestID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @RequestID = NewID()

                    INSERT
                    INTO [ItsAllAboutYou]
                    (
                        [RequestID],
                        [FirstName],
                        [LastName],
                        [Company],
                        [emailAddress],
                        [Phone],
                        [Address],
                        [City],
                        [State],
                        [PostalCode],
                        [Message],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @RequestID,
                        @FirstName,
                        @LastName,
                        @Company,
                        @emailAddress,
                        @Phone,
                        @Address,
                        @City,
                        @State,
                        @PostalCode,
                        @Message,
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
                    UPDATE [ItsAllAboutYou]
                    SET
                    [FirstName] = @FirstName,
                    [LastName] = @LastName,
                    [Company] = @Company,
                    [emailAddress] = @emailAddress,
                    [Phone] = @Phone,
                    [Address] = @Address,
                    [City] = @City,
                    [State] = @State,
                    [PostalCode] = @PostalCode,
                    [Message] = @Message,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [RequestID] = @RequestID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ItsAllAboutYou_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ItsAllAboutYou_Save Error on Creation'
GO




