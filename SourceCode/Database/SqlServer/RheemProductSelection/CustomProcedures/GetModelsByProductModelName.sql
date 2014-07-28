USE [rheemproductselection]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetModelsByProductModelName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetModelsByProductModelName]
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
CREATE PROCEDURE [dbo].[GetModelsByProductModelName] 
	-- Add the parameters for the stored procedure here
	@Model varchar(50),
	@categoryID uniqueidentifier,
	@brandID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;	

	DECLARE @brandName varchar(50) = (SELECT BrandName FROM rheemdb..Brand WHERE BrandID = @brandID)
	DECLARE @catName varchar(200) = (SELECT categoryname FROM rheemusers..ProductCategory where ProductCategoryID=@categoryID)
	DECLARE @whichSelect varchar(50) = ''

	SET @whichSelect = (SELECT CASE 
			WHEN @catName = 'Gas Furnaces' THEN 'FURN'
			WHEN @catName = 'Condensing Units' THEN 'Condenser'
			WHEN @catName = 'Heat Pumps' THEN 'Condenser'
			WHEN @catName = 'Package Air Conditioners' THEN 'Condenser'
			WHEN @catName = 'Package Heat Pumps' THEN 'Condenser'
			WHEN @catName = 'Dual Fuel' THEN 'Condenser'
			WHEN @catName = 'Package Gas/Electric' THEN 'Condenser'
			WHEN @catName = 'Split System Condensing  Unit' THEN 'Condenser'
			WHEN @catName = 'Split System Heat Pumps' THEN 'Condenser'
			WHEN @catName = 'Cooling Coils' THEN 'DXCoil'
			WHEN @catName = 'Air Handlers' THEN 'Air_Hand'
	    END)

	IF @whichSelect = 'Condenser' 
	BEGIN
		SELECT ID, Model, Tonnage, Status, Voltage, Height, Width, Length, @brandName As Brand 
		FROM rheemproductselection..Condenser 
		WHERE model like @model + '%' and status=4
		ORDER BY Model
	END

	IF @whichSelect = 'FURN'
	BEGIN
		SELECT ID, Model, '0' As Tonnage, Status, '0' As Voltage, Height, Width, Depth As Length, @brandName As Brand 
		FROM rheemproductselection..FURN 
		WHERE model like @model + '%' and Manuf=@brandName and status=4
		ORDER BY Model
	END

	IF @whichSelect = 'DXCoil'
	BEGIN
		SELECT ID, ARIModel AS Model, Tonnage, Status, '0' As Voltage, Height, Width, Depth As Length, @brandName As Brand 
		FROM rheemproductselection..DxCoil 
		WHERE ARIModel like @model + '%' and status=4
		ORDER BY ARIModel
	END

	IF @whichSelect = 'Air_Hand'
	BEGIN
		SELECT ID, ARIModel AS Model, Tonnage, Status, Voltage, Height, Width, Depth As Length, @brandName As Brand 
		FROM rheemproductselection..Air_Hand 
		WHERE ARIModel like @model + '%' and Manuf=@brandName and status=4
		ORDER BY ARIModel, Voltage
	END

END
GO

   
