USE [Warranty]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetWarrantyDatesForSerial]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetWarrantyDatesForSerial]
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
CREATE PROCEDURE [dbo].[GetWarrantyDatesForSerial] 
	-- Add the parameters for the stored procedure here
	@UnitSerial varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select u.RegistrationDate, u.InstallDate from Units u
	   inner join HomeOwners h on u.HomeOwnerID=h.HomeOwnerID and OracleStatus='REGISTERED'
	   where UnitSerial = @UnitSerial

END
GO
