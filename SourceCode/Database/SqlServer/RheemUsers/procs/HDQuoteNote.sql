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
   Get rid of obsolete InsertHDQuoteNote
   Get rid of obsolete UpdateHDQuoteNote
   Get rid of obsolete DeleteHDQuoteNote
   Get rid of obsolete SearchHDQuoteNoteByString
   Get rid of obsolete GetHDQuoteNoteByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertHDQuoteNote') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertHDQuoteNote;
        PRINT 'Dropped InsertHDQuoteNote'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateHDQuoteNote') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateHDQuoteNote;
        PRINT 'Dropped UpdateHDQuoteNote'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteHDQuoteNote') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteHDQuoteNote;
        PRINT 'Dropped DeleteHDQuoteNote'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchHDQuoteNoteByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchHDQuoteNoteByString;
        PRINT 'Dropped SearchHDQuoteNoteByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetHDQuoteNoteByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetHDQuoteNoteByID;
        PRINT 'Dropped GetHDQuoteNoteByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDQuoteNote_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDQuoteNote_GetByID;
        PRINT 'Dropped spGen__HDQuoteNote_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDQuoteNote_GetByID

   Description:  Selects record(s) from table 'HDQuoteNote'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDQuoteNote_GetByID
(
    @HDQuoteNoteID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [HDQuoteNoteID],[HDQuoteID],[SeqNumIdentity],[NoteTimeStamp],[PersonID],[NoteText],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HDQuoteNote]
    WHERE [HDQuoteNoteID] = @HDQuoteNoteID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDQuoteNote_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__HDQuoteNote_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDQuoteNote_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDQuoteNote_SearchByString;
        PRINT 'Dropped spGen__HDQuoteNote_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDQuoteNote_SearchByString

   Description:  Selects a record from table 'HDQuoteNote'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDQuoteNote_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [HDQuoteNoteID],[HDQuoteID],[SeqNumIdentity],[NoteTimeStamp],[PersonID],[NoteText],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HDQuoteNote]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDQuoteNote_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__HDQuoteNote_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDQuoteNote_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDQuoteNote_Delete;
        PRINT 'Dropped spGen__HDQuoteNote_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDQuoteNote_Delete

   Description:  Deletes a record from table 'HDQuoteNote'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDQuoteNote_Delete
(
    @HDQuoteNoteID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [HDQuoteNote]
    WHERE [HDQuoteNoteID] = @HDQuoteNoteID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDQuoteNote_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__HDQuoteNote_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDQuoteNote_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDQuoteNote_Save;
        PRINT 'Dropped spGen__HDQuoteNote_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDQuoteNote_Save

   Description:  Updates or Deletes a record In table 'HDQuoteNote'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDQuoteNote_Save
(
    @ErrText varchar(4000) output,
    @HDQuoteNoteID uniqueidentifier output,
    @HDQuoteID uniqueidentifier,
    @NoteTimeStamp datetime,
    @PersonID uniqueidentifier,
    @NoteText varchar(1000)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @HDQuoteNoteID = '00000000-0000-0000-0000-000000000000' SET @HDQuoteNoteID = NULL
    IF @HDQuoteNoteID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @HDQuoteNoteID = NewID()

                    INSERT
                    INTO [HDQuoteNote]
                    (
                        [HDQuoteNoteID],
                        [HDQuoteID],
                        [NoteTimeStamp],
                        [PersonID],
                        [NoteText],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @HDQuoteNoteID,
                        @HDQuoteID,
                        @NoteTimeStamp,
                        @PersonID,
                        @NoteText,
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
                    UPDATE [HDQuoteNote]
                    SET
                    [HDQuoteID] = @HDQuoteID,
                    [NoteTimeStamp] = @NoteTimeStamp,
                    [PersonID] = @PersonID,
                    [NoteText] = @NoteText,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [HDQuoteNoteID] = @HDQuoteNoteID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDQuoteNote_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__HDQuoteNote_Save Error on Creation'
GO




