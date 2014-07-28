USE [rheemevents]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRheemEventTasks]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRheemEventTasks]
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
CREATE PROCEDURE [dbo].[GetRheemEventTasks] 
	-- Add the parameters for the stored procedure here
	@RheemEventID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT * 
	FROM rheemevents..Task a, 
		 rheemevents..RheemEventTask b
	WHERE a.TaskID = b.TaskID and
	      b.RheemEventID=@RheemEventID
	ORDER BY a.TaskOrder

END
GO
