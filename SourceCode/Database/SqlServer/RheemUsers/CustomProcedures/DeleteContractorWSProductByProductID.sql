USE [RheemUsers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteContractorWSProductByProductID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteContractorWSProductByProductID]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorWSProductByProductID
   
   Description:  Deletes a record from table 'ContractorWSProduct' By ProductID
   
   AUTHOR:       Rheem Manufacturing, Brian White - 2/29/2012 9:30:58 AM

   ------------------------------------------------------------ */

CREATE PROCEDURE [dbo].[DeleteContractorWSProductByProductID]
(
	@ProductID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorWSProduct] 
	WHERE [ProductID] = @ProductID
		

	Set @Err = @@Error

	RETURN @Err
End
