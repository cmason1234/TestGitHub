USE [WaterHeaterDB]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bspGetBOLHeaderInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[bspGetBOLHeaderInfo]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[bspGetBOLHeaderInfo]
(@BOLNumber varchar(20))

AS

SELECT TOP 1 
	mtmsBOLSerialNumbers.CustomerNumber, 
	mtmsBOLSerialNumbers.ShipmentBOLNumber, 
	AccumCustomer.CustName, 
	mtmsBOLSerialNumbers.ShipAddress, 
	mtmsBOLSerialNumbers.ShipAddress2, 
	mtmsBOLSerialNumbers.ShipCity, 
	mtmsBOLSerialNumbers.ShipState, 
	mtmsBOLSerialNumbers.ShipZip
FROM mtmsBOLSerialNumbers
    INNER JOIN RheemUsers..DistributorOrganization do on mtmsBOLSerialNumbers.CustomerNumber=do.OracleAccountNumber
    INNER JOIN AccumCustomer ON  do.OracleCustomerSiteNumberWHD = AccumCustomer.CustNumber
WHERE  mtmsBOLSerialNumbers.ShipmentBOLNumber = @BOLNumber

GO
