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
   Get rid of obsolete InsertPersonClipArt
   Get rid of obsolete UpdatePersonClipArt
   Get rid of obsolete DeletePersonClipArt
   Get rid of obsolete SearchPersonClipArtByString
   Get rid of obsolete GetPersonClipArtByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertPersonClipArt') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertPersonClipArt;
        PRINT 'Dropped InsertPersonClipArt'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatePersonClipArt') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdatePersonClipArt;
        PRINT 'Dropped UpdatePersonClipArt'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletePersonClipArt') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeletePersonClipArt;
        PRINT 'Dropped DeletePersonClipArt'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchPersonClipArtByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchPersonClipArtByString;
        PRINT 'Dropped SearchPersonClipArtByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetPersonClipArtByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetPersonClipArtByID;
        PRINT 'Dropped GetPersonClipArtByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__PersonClipArt_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__PersonClipArt_GetByID;
        PRINT 'Dropped spGen__PersonClipArt_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__PersonClipArt_GetByID

   Description:  Selects record(s) from table 'PersonClipArt'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__PersonClipArt_GetByID
(
    @PersonClipArtID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [PersonClipArtID],[PersonId],[DocumentID],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [PersonClipArt]
    WHERE [PersonClipArtID] = @PersonClipArtID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__PersonClipArt_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__PersonClipArt_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__PersonClipArt_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__PersonClipArt_SearchByString;
        PRINT 'Dropped spGen__PersonClipArt_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__PersonClipArt_SearchByString

   Description:  Selects a record from table 'PersonClipArt'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__PersonClipArt_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [PersonClipArtID],[PersonId],[DocumentID],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [PersonClipArt]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__PersonClipArt_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__PersonClipArt_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__PersonClipArt_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__PersonClipArt_Delete;
        PRINT 'Dropped spGen__PersonClipArt_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__PersonClipArt_Delete

   Description:  Deletes a record from table 'PersonClipArt'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__PersonClipArt_Delete
(
    @PersonClipArtID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [PersonClipArt]
    WHERE [PersonClipArtID] = @PersonClipArtID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__PersonClipArt_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__PersonClipArt_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__PersonClipArt_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__PersonClipArt_Save;
        PRINT 'Dropped spGen__PersonClipArt_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__PersonClipArt_Save

   Description:  Updates or Deletes a record In table 'PersonClipArt'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__PersonClipArt_Save
(
    @ErrText varchar(4000) output,
    @PersonClipArtID uniqueidentifier output,
    @PersonId uniqueidentifier,
    @DocumentID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @PersonClipArtID = '00000000-0000-0000-0000-000000000000' SET @PersonClipArtID = NULL
    IF @PersonClipArtID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @PersonClipArtID = NewID()

                    INSERT
                    INTO [PersonClipArt]
                    (
                        [PersonClipArtID],
                        [PersonId],
                        [DocumentID],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @PersonClipArtID,
                        @PersonId,
                        @DocumentID,
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
                    UPDATE [PersonClipArt]
                    SET
                    [PersonId] = @PersonId,
                    [DocumentID] = @DocumentID,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [PersonClipArtID] = @PersonClipArtID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__PersonClipArt_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__PersonClipArt_Save Error on Creation'
GO




