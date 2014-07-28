USE [WaterHeaterDB]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bspResInvGetModelNumbers_MTMS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[bspResInvGetModelNumbers_MTMS]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[bspResInvGetModelNumbers_MTMS]
(@tradeBrand varchar(50), 
@energyType varchar(50))

AS

SET NOCOUNT ON

SELECT DISTINCT marketingModelNumber
FROM mtmsResInventory
WHERE tradeBrand = @tradeBrand AND energyType = @energyType
ORDER BY marketingModelNumber
