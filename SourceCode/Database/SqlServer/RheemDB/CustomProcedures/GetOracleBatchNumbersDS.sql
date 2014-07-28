USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOracleBatchNumbersDS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetOracleBatchNumbersDS]
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
CREATE PROCEDURE [dbo].[GetOracleBatchNumbersDS] 
	-- Add the parameters for the stored procedure here
	-- no parameters
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    Select distinct cast(OracleBatchNumber  as varchar(100))  varOracleBatchNum, OracleBatchNumber 
	FROM EC_Claims 
	WHERE OracleBatchNumber > 0 
	ORDER BY OracleBatchNumber desc

END
GO
