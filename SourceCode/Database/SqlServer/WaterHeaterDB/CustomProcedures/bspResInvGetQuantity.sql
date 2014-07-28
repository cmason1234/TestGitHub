USE [WaterHeaterDB]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bspResInvGetQuantity]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[bspResInvGetQuantity]
GO


/****** Object:  StoredProcedure [dbo].[bspResInvGetQuantity]    Script Date: 08/28/2012 11:41:40 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[bspResInvGetQuantity](@marketingModelNumber varchar(25))

AS

SET NOCOUNT ON

SELECT marketingModelNumber, warehouseNumber, warehouseCity, warehouseState,
  quantityOnHand, PartDescription, PartNumber, 'in stock' as availability,
  isNull(warehouseCity, 'None') + ', ' + isNull(warehouseState, '') as warehouseLocation,
  partNumber
FROM mtmsResInventory
WHERE 
warehouseCity not in (
'Montevideo', 'Vicksburg' ,
'Salisbury', 'Elkhart', 
'Ashburn', 'Lakeland', 
'Phoenix', 'Marshfield', 
'Arlington', 'Vancouver', 
'Clinton', 'Haleyville', 
'Elizatbethtown','Nampa', 'Riverside') and 
marketingModelNumber = @marketingModelNumber
ORDER BY warehouseLocation

GO

