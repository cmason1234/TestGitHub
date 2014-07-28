USE [rheemevents]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRheemEventsAndTasksByYear]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRheemEventsAndTasksByYear]
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
CREATE PROCEDURE [dbo].[GetRheemEventsAndTasksByYear] 
	-- Add the parameters for the stored procedure here
	@Year int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT a.RheemEventID,a.Title As EventTitle,a.ColorForCalendar,
           b.DueDate,b.IsCompleted,c.Title As TaskTitle 
    FROM   rheemevents..RheemEvent a, rheemevents..RheemEventTask b, rheemevents..Task c
    WHERE  a.RheemEventID = b.RheemEventID and
           b.TaskID = c.TaskID and
           YEAR(b.DueDate) = @Year

END
GO
