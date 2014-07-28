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
   Get rid of obsolete InsertSharedSecret
   Get rid of obsolete UpdateSharedSecret
   Get rid of obsolete DeleteSharedSecret
   Get rid of obsolete SearchSharedSecretByString
   Get rid of obsolete GetSharedSecretByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertSharedSecret') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertSharedSecret;
        PRINT 'Dropped InsertSharedSecret'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateSharedSecret') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateSharedSecret;
        PRINT 'Dropped UpdateSharedSecret'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteSharedSecret') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteSharedSecret;
        PRINT 'Dropped DeleteSharedSecret'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchSharedSecretByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchSharedSecretByString;
        PRINT 'Dropped SearchSharedSecretByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetSharedSecretByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetSharedSecretByID;
        PRINT 'Dropped GetSharedSecretByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__SharedSecret_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__SharedSecret_GetByID;
        PRINT 'Dropped spGen__SharedSecret_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__SharedSecret_GetByID

   Description:  Selects record(s) from table 'SharedSecret'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__SharedSecret_GetByID
(
    @SharedSecretID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [SharedSecretID],[PersonID],[ExpirationDate],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [SharedSecret]
    WHERE [SharedSecretID] = @SharedSecretID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__SharedSecret_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__SharedSecret_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__SharedSecret_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__SharedSecret_SearchByString;
        PRINT 'Dropped spGen__SharedSecret_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__SharedSecret_SearchByString

   Description:  Selects a record from table 'SharedSecret'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__SharedSecret_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [SharedSecretID],[PersonID],[ExpirationDate],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [SharedSecret]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__SharedSecret_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__SharedSecret_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__SharedSecret_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__SharedSecret_Delete;
        PRINT 'Dropped spGen__SharedSecret_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__SharedSecret_Delete

   Description:  Deletes a record from table 'SharedSecret'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__SharedSecret_Delete
(
    @SharedSecretID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [SharedSecret]
    WHERE [SharedSecretID] = @SharedSecretID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__SharedSecret_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__SharedSecret_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__SharedSecret_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__SharedSecret_Save;
        PRINT 'Dropped spGen__SharedSecret_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__SharedSecret_Save

   Description:  Updates or Deletes a record In table 'SharedSecret'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__SharedSecret_Save
(
    @ErrText varchar(4000) output,
    @SharedSecretID uniqueidentifier output,
    @PersonID uniqueidentifier,
    @ExpirationDate datetime
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @SharedSecretID = '00000000-0000-0000-0000-000000000000' SET @SharedSecretID = NULL
    IF @SharedSecretID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @SharedSecretID = NewID()

                    INSERT
                    INTO [SharedSecret]
                    (
                        [SharedSecretID],
                        [PersonID],
                        [ExpirationDate],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @SharedSecretID,
                        @PersonID,
                        @ExpirationDate,
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
                    UPDATE [SharedSecret]
                    SET
                    [PersonID] = @PersonID,
                    [ExpirationDate] = @ExpirationDate,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [SharedSecretID] = @SharedSecretID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__SharedSecret_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__SharedSecret_Save Error on Creation'
GO




