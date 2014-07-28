USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductWHModels]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductWHModels]
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
CREATE PROCEDURE [dbo].[GetProductWHModels] 
	-- Add the parameters for the stored procedure here
        @description varchar(256),
		@gallonCapacityID uniqueidentifier,
		@voltageID uniqueidentifier,
		@btuID uniqueidentifier,
		@wattID uniqueidentifier,
		@brandID uniqueidentifier,
		@commercial varchar(50),
		@UPC varchar(256),
		@baseModel varchar(256),
		@catalogCode varchar(256),
		@configString varchar(256),
		@altCode varchar(256)
AS
BEGIN

        select null As notthere, wh.*, g.Capacity, v.Voltage, b.BTU, br.BrandName, bm.BaseModel,
          CAST(w1.Watt AS varchar(5)) + '/' + CAST(w2.Watt AS varchar(5)) As Watt1 
         from ProductWHUPC wh
		 INNER JOIN ProductWHGallonCapacity g ON wh.ProductWHGallonCapacityID=g.ProductWHGallonCapacityID
		 INNER JOIN ProductWHVoltage v ON wh.ProductWHVoltageID=v.ProductWHVoltageID
         INNER JOIN ProductWHBTU b ON wh.ProductWHBTUID=b.ProductWHBTUID
		 INNER JOIN ProductWHWatt w1 ON wh.ProductWHWatt1ID=w1.ProductWHWattID
		 INNER JOIN ProductWHWatt w2 ON wh.ProductWHWatt2ID=w2.ProductWHWattID
		 INNER JOIN ProductWHBaseModel bm ON wh.ProductWHBaseModelID=bm.ProductWHBaseModelID
		 INNER JOIN rheemdb..Brand br ON wh.BrandID=br.BrandID
		 WHERE (LEN(@Description)=0 or wh.Description like '%' + @Description + '%') AND
		   (@gallonCapacityID IS NULL or wh.ProductWHGallonCapacityID=@gallonCapacityID) AND
           (@btuID IS NULL OR wh.ProductWHBTUID=@btuID) AND
		   (@wattID IS NULL OR wh.ProductWHWatt1ID=@wattID or wh.ProductWHWatt2ID=@wattID) AND
           (@brandID IS NULL or wh.BrandID=@brandID) AND
           (LEN(@UPC)=0 or  wh.UPC like '%' + @UPC + '%') AND
           (LEN(@baseModel)=0 or bm.BaseModel like '%' + baseModel + '%') AND
           (LEN(@catalogCode)=0 or wh.CatalogCode like '%' + catalogCode + '%') AND
           (LEN(@configString)=0 or wh.ConfigurationString like '%' + @configString + '%') AND
           (LEN(@altCode)=0 or wh.AlternateCode like '%' + @altCode + '%') AND
		   ((@commercial = 'C' AND wh.Commercial=1 AND wh.Residential=0) OR
		    (@commercial = 'R' AND wh.Commercial=0 and wh.Residential=1) OR
			(@commercial = 'B' AND (wh.Commercial=1 or wh.Residential=1)) OR
			(@commercial = 'N' AND wh.Commercial=0 and wh.Residential=0))
END
GO

