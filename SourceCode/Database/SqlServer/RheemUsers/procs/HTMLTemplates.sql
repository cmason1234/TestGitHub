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
   Get rid of obsolete InsertHTMLTemplates
   Get rid of obsolete UpdateHTMLTemplates
   Get rid of obsolete DeleteHTMLTemplates
   Get rid of obsolete SearchHTMLTemplatesByString
   Get rid of obsolete GetHTMLTemplatesByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertHTMLTemplates') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertHTMLTemplates;
        PRINT 'Dropped InsertHTMLTemplates'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateHTMLTemplates') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateHTMLTemplates;
        PRINT 'Dropped UpdateHTMLTemplates'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteHTMLTemplates') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteHTMLTemplates;
        PRINT 'Dropped DeleteHTMLTemplates'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchHTMLTemplatesByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchHTMLTemplatesByString;
        PRINT 'Dropped SearchHTMLTemplatesByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetHTMLTemplatesByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetHTMLTemplatesByID;
        PRINT 'Dropped GetHTMLTemplatesByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HTMLTemplates_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HTMLTemplates_GetByID;
        PRINT 'Dropped spGen__HTMLTemplates_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HTMLTemplates_GetByID

   Description:  Selects record(s) from table 'HTMLTemplates'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HTMLTemplates_GetByID
(
    @HTMLTemplateID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [HTMLTemplateID],[TemplateName],[Template],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HTMLTemplates]
    WHERE [HTMLTemplateID] = @HTMLTemplateID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HTMLTemplates_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__HTMLTemplates_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HTMLTemplates_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HTMLTemplates_SearchByString;
        PRINT 'Dropped spGen__HTMLTemplates_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HTMLTemplates_SearchByString

   Description:  Selects a record from table 'HTMLTemplates'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HTMLTemplates_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [HTMLTemplateID],[TemplateName],[Template],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HTMLTemplates]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__HTMLTemplates_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__HTMLTemplates_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HTMLTemplates_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HTMLTemplates_Delete;
        PRINT 'Dropped spGen__HTMLTemplates_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HTMLTemplates_Delete

   Description:  Deletes a record from table 'HTMLTemplates'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HTMLTemplates_Delete
(
    @HTMLTemplateID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [HTMLTemplates]
    WHERE [HTMLTemplateID] = @HTMLTemplateID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HTMLTemplates_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__HTMLTemplates_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HTMLTemplates_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HTMLTemplates_Save;
        PRINT 'Dropped spGen__HTMLTemplates_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HTMLTemplates_Save

   Description:  Updates or Deletes a record In table 'HTMLTemplates'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HTMLTemplates_Save
(
    @ErrText varchar(4000) output,
    @HTMLTemplateID uniqueidentifier output,
    @TemplateName varchar(50),
    @Template text
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @HTMLTemplateID = '00000000-0000-0000-0000-000000000000' SET @HTMLTemplateID = NULL
    IF @HTMLTemplateID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @HTMLTemplateID = NewID()

                    INSERT
                    INTO [HTMLTemplates]
                    (
                        [HTMLTemplateID],
                        [TemplateName],
                        [Template],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @HTMLTemplateID,
                        @TemplateName,
                        @Template,
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
                    UPDATE [HTMLTemplates]
                    SET
                    [TemplateName] = @TemplateName,
                    [Template] = @Template,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [HTMLTemplateID] = @HTMLTemplateID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HTMLTemplates_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__HTMLTemplates_Save Error on Creation'
GO




