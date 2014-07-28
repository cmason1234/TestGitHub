USE [rheemusers]
GO
 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductModelWH]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductModelWH]
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
CREATE PROCEDURE [dbo].[GetProductModelWH] 
	-- Add the parameters for the stored procedure here
	@ProductModelWHID uniqueidentifier
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	

	SELECT * FROM rheemusers..ProductModelWH pmwh
		INNER JOIN RheemUsers..ProductModelWHTank  pmwht ON 
			pmwh.ProductModelWHID = pmwht.ProductModelWHID 
		INNER JOIN RheemUsers..ProductModelWHTankless  pmwhtless ON 
			pmwh.ProductModelWHID = pmwhtless.ProductModelWHID 
		INNER JOIN RheemUsers..ProductModelWHSolar  pmwhs ON 
			pmwh.ProductModelWHID = pmwhs.ProductModelWHID 
	WHERE 
		pmwh.ProductModelWHID=@ProductModelWHID 
	ORDER BY pmwh.Model
			
END
GO

   
