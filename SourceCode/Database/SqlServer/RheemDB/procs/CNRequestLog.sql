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
   Get rid of obsolete InsertCNRequestLog
   Get rid of obsolete UpdateCNRequestLog
   Get rid of obsolete DeleteCNRequestLog
   Get rid of obsolete SearchCNRequestLogByString
   Get rid of obsolete GetCNRequestLogByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertCNRequestLog') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertCNRequestLog;
        PRINT 'Dropped InsertCNRequestLog'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateCNRequestLog') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateCNRequestLog;
        PRINT 'Dropped UpdateCNRequestLog'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteCNRequestLog') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteCNRequestLog;
        PRINT 'Dropped DeleteCNRequestLog'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchCNRequestLogByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchCNRequestLogByString;
        PRINT 'Dropped SearchCNRequestLogByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetCNRequestLogByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetCNRequestLogByID;
        PRINT 'Dropped GetCNRequestLogByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__CNRequestLog_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__CNRequestLog_GetByID;
        PRINT 'Dropped spGen__CNRequestLog_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__CNRequestLog_GetByID

   Description:  Selects record(s) from table 'CNRequestLog'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__CNRequestLog_GetByID
(
    @CNRequestLogID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [CNRequestLogID],[CNRequestID],[SeqID],[LogText]
    FROM [CNRequestLog]
    WHERE [CNRequestLogID] = @CNRequestLogID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__CNRequestLog_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__CNRequestLog_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__CNRequestLog_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__CNRequestLog_SearchByString;
        PRINT 'Dropped spGen__CNRequestLog_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__CNRequestLog_SearchByString

   Description:  Selects a record from table 'CNRequestLog'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__CNRequestLog_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [CNRequestLogID],[CNRequestID],[SeqID],[LogText]
    FROM [CNRequestLog]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__CNRequestLog_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__CNRequestLog_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__CNRequestLog_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__CNRequestLog_Delete;
        PRINT 'Dropped spGen__CNRequestLog_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__CNRequestLog_Delete

   Description:  Deletes a record from table 'CNRequestLog'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__CNRequestLog_Delete
(
    @CNRequestLogID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [CNRequestLog]
    WHERE [CNRequestLogID] = @CNRequestLogID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__CNRequestLog_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__CNRequestLog_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__CNRequestLog_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__CNRequestLog_Save;
        PRINT 'Dropped spGen__CNRequestLog_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__CNRequestLog_Save

   Description:  Updates or Deletes a record In table 'CNRequestLog'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__CNRequestLog_Save
(
    @ErrText varchar(4000) output,
    @CNRequestLogID uniqueidentifier output,
    @CNRequestID uniqueidentifier,
    @SeqID int,
    @LogText varchar(512)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @CNRequestLogID = '00000000-0000-0000-0000-000000000000' SET @CNRequestLogID = NULL
    IF @CNRequestLogID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @CNRequestLogID = NewID()

                    INSERT
                    INTO [CNRequestLog]
                    (
                        [CNRequestLogID],
                        [CNRequestID],
                        [SeqID],
                        [LogText]
                    )
                    VALUES
                    (
                        @CNRequestLogID,
                        @CNRequestID,
                        @SeqID,
                        @LogText
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
                    UPDATE [CNRequestLog]
                    SET
                    [CNRequestID] = @CNRequestID,
                    [SeqID] = @SeqID,
                    [LogText] = @LogText
                    WHERE [CNRequestLogID] = @CNRequestLogID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__CNRequestLog_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__CNRequestLog_Save Error on Creation'
GO




