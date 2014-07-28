USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetWaterHeaterOrderDetails_MTMS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetWaterHeaterOrderDetails_MTMS]
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
CREATE PROCEDURE [dbo].[GetWaterHeaterOrderDetails_MTMS] 
	-- Add the parameters for the stored procedure here
	@CustomerNumber varchar(4000),
	@PurchaseOrderNumber varchar(4000),
	@RheemNum varchar(4000)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	select ship_to_name, ship_to_address1, ship_to_address2, ship_to_city, ship_to_state, ship_to_zip,
	  max(del_appointment_date) as del_appointment_date, max(del_appointment_time) as del_appointment_time,
	  max(actual_shipment_date) as schedule_ship_date, ord_header_status, po_date 
	from WHOrders 
    where legacy_customer_number = @CustomerNumber  and 
	    cust_po = @PurchaseOrderNumber and 
		sales_order_num = @RheemNum 
	group by ship_to_name, ship_to_address1, ship_to_address2, ship_to_city, 
	  ship_to_state, ship_to_zip, ord_header_status, po_date
	  
	
	select order_line, upc_number, marketing_model, carrier_name ,tracking_number, 
	    bol_number, line_status, sum(order_qty) as OrderQuantity, SUM(shipped_qty) shipQuantity 
	from WHOrders 
	where legacy_customer_number = @CustomerNumber and
    	cust_po = @PurchaseOrderNumber and
		sales_order_num = @RheemNum 
	group by order_line, upc_number, marketing_model, carrier_name, 
	    tracking_number, bol_number, line_status
	order by order_line
END
GO
