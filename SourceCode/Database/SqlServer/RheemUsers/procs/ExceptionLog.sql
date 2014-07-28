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
   Get rid of obsolete InsertExceptionLog
   Get rid of obsolete UpdateExceptionLog
   Get rid of obsolete DeleteExceptionLog
   Get rid of obsolete SearchExceptionLogByString
   Get rid of obsolete GetExceptionLogByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertExceptionLog') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertExceptionLog;
        PRINT 'Dropped InsertExceptionLog'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateExceptionLog') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateExceptionLog;
        PRINT 'Dropped UpdateExceptionLog'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteExceptionLog') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteExceptionLog;
        PRINT 'Dropped DeleteExceptionLog'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchExceptionLogByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchExceptionLogByString;
        PRINT 'Dropped SearchExceptionLogByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetExceptionLogByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetExceptionLogByID;
        PRINT 'Dropped GetExceptionLogByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ExceptionLog_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ExceptionLog_GetByID;
        PRINT 'Dropped spGen__ExceptionLog_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ExceptionLog_GetByID

   Description:  Selects record(s) from table 'ExceptionLog'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ExceptionLog_GetByID
(
    @ExceptionLogID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [ExceptionLogID],[ErrMessage],[ErrStack],[ErrSource],[PersonID],[ErrDateTime],[ErrPage],[ErrFirstLineNumber],[Referrer],[IP_Addr],[FatalBit],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ExceptionLog]
    WHERE [ExceptionLogID] = @ExceptionLogID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ExceptionLog_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__ExceptionLog_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ExceptionLog_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ExceptionLog_SearchByString;
        PRINT 'Dropped spGen__ExceptionLog_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ExceptionLog_SearchByString

   Description:  Selects a record from table 'ExceptionLog'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ExceptionLog_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [ExceptionLogID],[ErrMessage],[ErrStack],[ErrSource],[PersonID],[ErrDateTime],[ErrPage],[ErrFirstLineNumber],[Referrer],[IP_Addr],[FatalBit],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [ExceptionLog]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__ExceptionLog_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__ExceptionLog_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ExceptionLog_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ExceptionLog_Delete;
        PRINT 'Dropped spGen__ExceptionLog_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ExceptionLog_Delete

   Description:  Deletes a record from table 'ExceptionLog'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ExceptionLog_Delete
(
    @ExceptionLogID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [ExceptionLog]
    WHERE [ExceptionLogID] = @ExceptionLogID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ExceptionLog_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__ExceptionLog_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__ExceptionLog_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__ExceptionLog_Save;
        PRINT 'Dropped spGen__ExceptionLog_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__ExceptionLog_Save

   Description:  Updates or Deletes a record In table 'ExceptionLog'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__ExceptionLog_Save
(
    @ErrText varchar(4000) output,
    @ExceptionLogID uniqueidentifier output,
    @ErrMessage text,
    @ErrStack text,
    @ErrSource text,
    @PersonID uniqueidentifier,
    @ErrDateTime datetime,
    @ErrPage varchar(4000),
    @ErrFirstLineNumber varchar(500),
    @Referrer varchar(250),
    @IP_Addr varchar(25),
    @FatalBit bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @ExceptionLogID = '00000000-0000-0000-0000-000000000000' SET @ExceptionLogID = NULL
    IF @ExceptionLogID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @ExceptionLogID = NewID()

                    INSERT
                    INTO [ExceptionLog]
                    (
                        [ExceptionLogID],
                        [ErrMessage],
                        [ErrStack],
                        [ErrSource],
                        [PersonID],
                        [ErrDateTime],
                        [ErrPage],
                        [ErrFirstLineNumber],
                        [Referrer],
                        [IP_Addr],
                        [FatalBit],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @ExceptionLogID,
                        @ErrMessage,
                        @ErrStack,
                        @ErrSource,
                        @PersonID,
                        @ErrDateTime,
                        @ErrPage,
                        @ErrFirstLineNumber,
                        @Referrer,
                        @IP_Addr,
                        @FatalBit,
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
                    UPDATE [ExceptionLog]
                    SET
                    [ErrMessage] = @ErrMessage,
                    [ErrStack] = @ErrStack,
                    [ErrSource] = @ErrSource,
                    [PersonID] = @PersonID,
                    [ErrDateTime] = @ErrDateTime,
                    [ErrPage] = @ErrPage,
                    [ErrFirstLineNumber] = @ErrFirstLineNumber,
                    [Referrer] = @Referrer,
                    [IP_Addr] = @IP_Addr,
                    [FatalBit] = @FatalBit,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [ExceptionLogID] = @ExceptionLogID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__ExceptionLog_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__ExceptionLog_Save Error on Creation'
GO




