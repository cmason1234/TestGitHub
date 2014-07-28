USE [WaterHeaterDB]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bspSerialNbrsPONbrByBOLwithPONbr]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[bspSerialNbrsPONbrByBOLwithPONbr]
GO


/****** Object:  StoredProcedure [dbo].[bspSerialNbrsPONbrByBOLwithPONbr]    Script Date: 09/29/2011 11:59:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[bspSerialNbrsPONbrByBOLwithPONbr]
	@BOLNumber varchar(20)
	,@PONumber varchar(25)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @POnumber as CustomerPurchaseOrderNumber, 
	PostedShipmentDate, 
	MarketingModel, 
	SerialNumber, 
	BaseModel, 
	UPC
FROM mtmsBOLSerialNumbers
WHERE ShipmentBOLNumber = @BOLNumber
ORDER BY ShipmentBOLNumber
END

GO


