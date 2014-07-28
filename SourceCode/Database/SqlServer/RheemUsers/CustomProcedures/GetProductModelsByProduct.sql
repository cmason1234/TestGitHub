USE [rheemusers]
GO
 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductModelsByProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductModelsByProduct]
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
CREATE PROCEDURE [dbo].[GetProductModelsByProduct] 
	-- Add the parameters for the stored procedure here
	@ProductID uniqueidentifier
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;	

	DECLARE @brandName varchar(50) = (SELECT BrandName FROM rheemdb..Brand where BrandID = (SELECT BrandID from rheemusers..Product where ProductID=@ProductID))
	DECLARE @catName varchar(200) = (SELECT categoryname FROM rheemusers..ProductCategory where ProductCategoryID=(SELECT ProductCategoryID from rheemusers..Product where ProductID=@ProductID))
	DECLARE @whichSelect varchar(50) = ''

	SET @whichSelect = (SELECT CASE 
			WHEN @catName = 'Gas Furnaces' THEN 'FURN'
			WHEN @catName = 'Condensing Units' THEN 'Condenser'
			WHEN @catName = 'Heat Pumps' THEN 'Condenser'
			WHEN @catName = 'Package Air Conditioners' THEN 'PackageAC'
			WHEN @catName = 'Package Heat Pumps' THEN 'PackageHP'
			WHEN @catName = 'Dual Fuel' THEN 'DualFuel'
			WHEN @catName = 'Package Gas/Electric' THEN 'PackageGasElect'
			WHEN @catName = 'Split System Condensing  Unit' THEN 'Condenser'
			WHEN @catName = 'Split System Heat Pumps' THEN 'Condenser'
			WHEN @catName = 'Cooling Coils' THEN 'DXCoil'
			WHEN @catName = 'Air Handlers' THEN 'Air_Hand'
			WHEN @catName = 'Residential Gas Water Heaters' THEN 'Res_Gss_WH'
	    END)

	IF @whichSelect = 'Res_Gss_WH'
	BEGIN
		SELECT * FROM rheemusers..ProductModelWH pmwh
			INNER JOIN RheemUsers..ProductModelWHTank  pmwht ON 
				pmwh.ProductModelWHID = pmwht.ProductModelWHID 
			INNER JOIN RheemUsers..ProductModelWHTankless  pmwhtless ON 
				pmwh.ProductModelWHID = pmwhtless.ProductModelWHID 
		WHERE 
			pmwh.ProductId=@ProductID 
		ORDER BY pmwh.Model
	END		
		
	IF @whichSelect = 'Condenser'
	BEGIN
		SELECT c.ID, 
			   c.Model, 
			   c.Tonnage, 
			   c.Status, 
			   (SELECT Power FROM rheemproductselection..voltage where Code='J') Voltage,
			   c.Height, 
			   c.Width, 
			   c.Length, 
			   c.Weight, 
			   c.LiquidConn, 
			   c.SuctionConn,
			   pm.ProductModelID,
			   @brandName AS Brand 
		FROM rheemproductselection..Condenser c
			INNER JOIN RheemUsers..ProductModel pm ON pm.rps_id = c.ID and pm.rps_model = c.Model and pm.rps_voltage = c.Voltage
		WHERE pm.ProductId=@ProductID 
		ORDER BY pm.RPS_Model
	END

	IF @whichSelect = 'FURN'
	BEGIN
		SELECT f.ID, 
			   f.Model, 
			   f.input, 
			   f.output, 
			   convert(varchar, f.airFlowLo)  + '-' + convert(varchar, f.airflowHi)  CoolingCFM,			   
			   '0' As Tonnage, 
			   f.Status, 
			   '0' AS Voltage, 
			   f.Height, 
			   f.Width, 
			   f.Depth As Length,
				f.Weight, 
				f.AFUE, 
				f.MtrType,
			   pm.ProductModelID,
			   @brandName AS Brand 
		FROM rheemproductselection..FURN f
			INNER JOIN RheemUsers..ProductModel pm ON pm.rps_id = f.ID and pm.rps_model = f.Model
		WHERE pm.ProductId=@ProductID and f.Manuf = @brandName
		ORDER BY pm.RPS_Model
	END

	IF @whichSelect = 'DXCoil'
	BEGIN
		SELECT d.ID, 
			   d.ARIModel AS Model, 
			   '0' As Tonnage, 
			   d.Status, 
			   '0' AS Voltage, 
			   d.Height, 
			   d.Width, 
			   d.Depth As Length, 
			   d.Weight,
			    convert(varchar, d.outwidth)  + '/' + convert(varchar, d.outdepth)  POpening,
			   d.FaceArea,
			   d.LiquidConn, 
			   d.SuctionConn,
			   pm.ProductModelID,
			   @brandName AS Brand 
		FROM rheemproductselection..DxCoil d
			INNER JOIN RheemUsers..ProductModel pm ON pm.rps_id = d.ID and pm.rps_model = d.ARIModel
		WHERE pm.ProductId=@ProductID 
		ORDER BY pm.RPS_Model
	END
	 
	IF @whichSelect = 'Air_Hand'
	BEGIN
		SELECT a.ID, 
			   a.ARIModel AS Model, 
			   a.ElecHtr,
			   a.Tonnage, 
			   a.AirFlowLo,
			   a.AirFlowHi,
			   a.Status, 
			   (SELECT Power FROM rheemproductselection..voltage where Code='J') Voltage,
			   a.Height, 
			   a.Depth As Length, 
			   a.Width, 
			   a.Weight, 
			   a.MCA,
			   pm.ProductModelID,
			   @brandName AS Brand  
		FROM rheemproductselection..Air_Hand a
			INNER JOIN RheemUsers..ProductModel pm ON pm.rps_id = a.ID and pm.rps_model = a.ARIModel
		WHERE pm.ProductId=@ProductID 
		ORDER BY pm.RPS_Model
	END
		
	IF @whichSelect = 'PackageAC'
	BEGIN
		SELECT c.ID, 
			   c.Model, 
			   a.Gross as GrossCapacity,
				c.IDCFM as NominalCFM,
				c.fuse as MaxOverProtectionDevice,
				(SELECT Power FROM rheemproductselection..voltage where Code=SUBSTRING(c.Model,10,1)) Voltage,
			   c.Height, 
			   c.Length, 
			   c.Width, 
			   c.Weight, 
			   pm.ProductModelID,
			   @brandName AS Brand 
		FROM rheemproductselection..Condenser c
			INNER JOIN RheemUsers..ProductModel pm ON 
				pm.rps_id = c.ID and 
				pm.rps_model = c.Model and 
				pm.rps_voltage = c.Voltage
			left outer join rheemproductselection..ARI a on 
				SUBSTRING(c.Model, 1, 11)=a.arimodel 
		WHERE pm.ProductId=@ProductID 
		ORDER BY pm.RPS_Model

	END
	IF @whichSelect = 'PackageHP' 
	BEGIN
		SELECT c.ID, 
			   c.Model, 
			   a.Gross as GrossCapacity,
				c.IDCFM as NominalCFM,
				c.fuse as MaxOverProtectionDevice,
				(SELECT Power FROM rheemproductselection..voltage where Code=SUBSTRING(c.Model,10,1)) Voltage,
			   c.Height, 
			   c.Length, 
			   c.Width, 
			   c.Weight, 
			   pm.ProductModelID,
			   @brandName AS Brand 
		FROM rheemproductselection..Condenser c
			INNER JOIN RheemUsers..ProductModel pm ON 
				pm.rps_id = c.ID and 
				pm.rps_model = c.Model and 
				pm.rps_voltage = c.Voltage
			left outer join rheemproductselection..ARI a on 
				SUBSTRING(c.Model, 1, 11)=a.arimodel 
		WHERE pm.ProductId=@ProductID 
		ORDER BY pm.RPS_Model

	END

	IF @whichSelect = 'DualFuel'
	BEGIN
		SELECT c.ID, 
			   c.Model, 
			   a.Gross as GrossCapacity,
				c.IDCFM as NominalCFM,
				c.GasInput as input, 
				c.GasOutput as Output,
				c.fuse as MaxOverProtectionDevice,
				(SELECT Power FROM rheemproductselection..voltage where Code=SUBSTRING(c.Model,10,1)) Voltage,
			   c.Height, 
			   c.Length, 
			   c.Width, 
			   c.Weight, 
			   (SELECT top 1 BeltDrive FROM rheemproductselection..Family where Family=SUBSTRING(c.Model,1,4)) BeltDrive,
			   (SELECT top 1 DirectDrive FROM rheemproductselection..Family where Family=SUBSTRING(c.Model,1,4)) DirectDrive,
			   c.Sound,
			   pm.ProductModelID,
			   @brandName AS Brand 
		FROM rheemproductselection..Condenser c
			INNER JOIN RheemUsers..ProductModel pm ON 
				pm.rps_id = c.ID and 
				pm.rps_model = c.Model and 
				pm.rps_voltage = c.Voltage
			inner join rheemproductselection..ARI a on 
				a.arimodel = SUBSTRING(c.Model, 1, 11)
		WHERE pm.ProductId=@ProductID 
		ORDER BY pm.RPS_Model

	END
	IF @whichSelect = 'PackageGasElect'
	BEGIN
		SELECT c.ID, 
			   c.Model, 
			   a.Gross as GrossCapacity,
				c.IDCFM as NominalCFM,
				c.fuse as MaxOverProtectionDevice,
				(SELECT Power FROM rheemproductselection..voltage where Code=SUBSTRING(c.Model,10,1)) Voltage, 
			   c.Height, 
			   c.Length, 
			   c.Width, 
			   c.Weight, 
			   pm.ProductModelID,
			   @brandName AS Brand 
		FROM rheemproductselection..Condenser c
			INNER JOIN RheemUsers..ProductModel pm ON 
				pm.rps_id = c.ID and 
				pm.rps_model = c.Model and 
				pm.rps_voltage = c.Voltage
			left outer join rheemproductselection..ARI a on 
				SUBSTRING(c.Model, 1, 11)=a.arimodel 
		WHERE pm.ProductId=@ProductID 
		ORDER BY pm.RPS_Model

	END
	
END
GO

   
