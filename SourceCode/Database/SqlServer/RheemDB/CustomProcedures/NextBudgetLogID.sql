USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NextBudgetLogID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[NextBudgetLogID]
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
CREATE PROCEDURE [dbo].[NextBudgetLogID] 
	-- Add the parameters for the stored procedure here
	@DistributorSelected uniqueidentifier,
	@Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT isnull(max(SeqID)+1, 1) as SeqID
	FROM RheemDB..EC_BudgetLog
    WHERE GDPYear = @Year and
          OrganizationID = @DistributorSelected

END
GO
