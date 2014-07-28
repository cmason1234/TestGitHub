USE [rheemevents]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAllRheemEventDependencies]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAllRheemEventDependencies]
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
CREATE PROCEDURE [dbo].[DeleteAllRheemEventDependencies] 
	-- Add the parameters for the stored procedure here
		@RheemEventID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	DELETE rheemevents..Booth WHERE RheemEventID=@RheemEventID
	DELETE rheemevents..RheemEventAddress WHERE RheemEventID=@RheemEventID
	DELETE rheemevents..RheemEventAsset WHERE RheemEventID=@RheemEventID
	DELETE rheemevents..RheemEventCollateral WHERE RheemEventID=@RheemEventID
	DELETE rheemevents..RheemEventDetail WHERE RheemEventID=@RheemEventID
	DELETE rheemevents..RheemEventHotel WHERE RheemEventID=@RheemEventID
	DELETE rheemevents..RheemEventPerson WHERE RheemEventID=@RheemEventID
	DELETE rheemevents..RheemEventTask WHERE RheemEventID=@RheemEventID
	DELETE rheemevents..RheemEventBudget WHERE RheemEventID=@RheemEventID

END
GO
