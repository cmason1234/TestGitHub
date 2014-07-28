USE [WaterHeaterDB]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bspResInvGetQuantity_MTMS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[bspResInvGetQuantity_MTMS]
GO


/****** Object:  StoredProcedure [dbo].[bspResInvGetQuantity]    Script Date: 08/28/2012 11:41:40 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[bspResInvGetQuantity_MTMS](@marketingModelNumber varchar(25))

AS

SET NOCOUNT ON

SELECT marketingModelNumber, warehouseNumber, warehouseCity, warehouseState,
  quantityOnHand, PartDescription, PartNumber, availability = 'in stock',
  warehouseLocation = CASE WHEN warehouseState IS NULL THEN warehouseCIty ELSE warehouseCity + ', ' + warehouseState END,
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

