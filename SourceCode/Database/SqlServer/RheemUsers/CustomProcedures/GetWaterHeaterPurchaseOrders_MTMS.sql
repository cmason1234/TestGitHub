USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetWaterHeaterPurchaseOrders_MTMS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetWaterHeaterPurchaseOrders_MTMS]
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
CREATE PROCEDURE [dbo].[GetWaterHeaterPurchaseOrders_MTMS] 
	-- Add the parameters for the stored procedure here
	@CustomerNumber varchar(4000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT DISTINCT cust_po, po_date, sales_order_num, 
	    ord_header_status, max(actual_shipment_date) as schedule_ship_date
	FROM WHOrders WHERE legacy_customer_number = @CustomerNumber
	GROUP BY cust_po, sales_order_num, ord_header_status, po_date 
	ORDER BY cust_po, sales_order_num
END
GO
