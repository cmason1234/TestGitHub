USE [WaterHeaterDB]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bspSerialNbrsByCustomer_MTMS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[bspSerialNbrsByCustomer_MTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[bspSerialNbrsByCustomer_MTMS](@CustomerNumber varchar(20))

AS
BEGIN
DECLARE @Today smalldatetime,
	@FromDate smalldatetime

SET @Today = GETDATE()

SET @FromDate = DATEADD(day,-60,@Today)

SELECT CustomerPurchaseOrderNumber, 
	PostedShipmentDate, 
	MarketingModel, 
	SerialNumber, 
	BaseModel, 
	UPC,
	ShipmentBOLNumber,
	ShipName,
	ShipAddress,
	ShipAddress2,
	ShipCIty,
	ShipState,
	ShipZip
FROM mtmsBOLSerialNumbers
WHERE CustomerNumber = @CustomerNumber
   AND PostedShipmentDate >= @FromDate
ORDER BY ShipmentBOLNumber

END

GO


