USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ECClaimsSectionApprovalRequired]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ECClaimsSectionApprovalRequired]
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
CREATE PROCEDURE [dbo].[ECClaimsSectionApprovalRequired] 
	-- Add the parameters for the stored procedure here
	@ClaimSectionCategoryId uniqueidentifier
AS
BEGIN
   SELECT ApprovalRequired 
   FROM rheemdb..EC_ClaimSectionCategory 
   WHERE ClaimsectionCategoryID = @ClaimSectionCategoryId
END
GO

