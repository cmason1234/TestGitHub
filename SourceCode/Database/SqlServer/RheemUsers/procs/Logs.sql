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
   Get rid of obsolete InsertLogs
   Get rid of obsolete UpdateLogs
   Get rid of obsolete DeleteLogs
   Get rid of obsolete SearchLogsByString
   Get rid of obsolete GetLogsByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertLogs') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertLogs;
        PRINT 'Dropped InsertLogs'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateLogs') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateLogs;
        PRINT 'Dropped UpdateLogs'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteLogs') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteLogs;
        PRINT 'Dropped DeleteLogs'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchLogsByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchLogsByString;
        PRINT 'Dropped SearchLogsByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetLogsByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetLogsByID;
        PRINT 'Dropped GetLogsByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__Logs_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__Logs_GetByID;
        PRINT 'Dropped spGen__Logs_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__Logs_GetByID

   Description:  Selects record(s) from table 'Logs'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__Logs_GetByID
(
    @LogID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [LogID],[ObjectID],[SeqID],[LogText],[LogDate],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [Logs]
    WHERE [LogID] = @LogID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__Logs_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__Logs_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__Logs_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__Logs_SearchByString;
        PRINT 'Dropped spGen__Logs_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__Logs_SearchByString

   Description:  Selects a record from table 'Logs'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__Logs_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [LogID],[ObjectID],[SeqID],[LogText],[LogDate],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [Logs]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__Logs_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__Logs_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__Logs_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__Logs_Delete;
        PRINT 'Dropped spGen__Logs_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__Logs_Delete

   Description:  Deletes a record from table 'Logs'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__Logs_Delete
(
    @LogID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [Logs]
    WHERE [LogID] = @LogID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__Logs_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__Logs_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__Logs_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__Logs_Save;
        PRINT 'Dropped spGen__Logs_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__Logs_Save

   Description:  Updates or Deletes a record In table 'Logs'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__Logs_Save
(
    @ErrText varchar(4000) output,
    @LogID uniqueidentifier output,
    @ObjectID uniqueidentifier,
    @SeqID int,
    @LogText varchar(256),
    @LogDate datetime
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @LogID = '00000000-0000-0000-0000-000000000000' SET @LogID = NULL
    IF @LogID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @LogID = NewID()

                    INSERT
                    INTO [Logs]
                    (
                        [LogID],
                        [ObjectID],
                        [SeqID],
                        [LogText],
                        [LogDate],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @LogID,
                        @ObjectID,
                        @SeqID,
                        @LogText,
                        @LogDate,
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
                    UPDATE [Logs]
                    SET
                    [ObjectID] = @ObjectID,
                    [SeqID] = @SeqID,
                    [LogText] = @LogText,
                    [LogDate] = @LogDate,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [LogID] = @LogID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__Logs_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__Logs_Save Error on Creation'
GO




