USE [rheemproductselection]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCondensersModelsBYProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCondensersModelsBYProduct]
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
CREATE PROCEDURE [dbo].[GetCondensersModelsBYProduct] 
	-- Add the parameters for the stored procedure here
	@Model varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;	

	select ID, Model, Tonnage, Status, Voltage, Height, Width, Length from rheemproductselection..Condenser 
		where
	model like @model + '%'
	order by Model

END
GO

   
