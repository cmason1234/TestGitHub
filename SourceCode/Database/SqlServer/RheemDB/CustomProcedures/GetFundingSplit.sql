USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetFundingSplit]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetFundingSplit]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFundingSplit] 
	-- Add the parameters for the stored procedure here
	@ClaimSectionCategoryID uniqueidentifier,
	@SingleValue bit
AS
BEGIN

	SET NOCOUNT ON;

    IF @SingleValue = 1
	  BEGIN
        SELECT FundingSplitSingleLine 
    	FROM rheemdb..EC_ClaimSectionCategory 
		WHERE ClaimSectionCategoryID = @ClaimSectionCategoryId
      END
    ELSE
	  BEGIN
        SELECT FundingSplit 
	    FROM rheemdb..EC_ClaimSectionCategory 
		WHERE ClaimSectionCategoryID = @ClaimSectionCategoryId
      END

END
GO

