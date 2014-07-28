USE [WaterHeaterDB]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bspComGasGetModelNumbers_MTMS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[bspComGasGetModelNumbers_MTMS]
GO

/****** Object:  StoredProcedure [dbo].[bspComGasGetModelNumbers]    Script Date: 11/19/2012 14:51:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[bspComGasGetModelNumbers_MTMS]
(@fuelType varchar(50) ,
@dutyType varchar(7))

 AS

SELECT distinct(marketingModelNumber)
FROM mtmsInventory
WHERE (fuelType = 'NG' OR fuelType = 'LP')
	AND dutyType = @dutyType
