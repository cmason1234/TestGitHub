USE [rheemevents]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRheemEventsForSingleAsset]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRheemEventsForSingleAsset]
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
CREATE PROCEDURE [dbo].[GetRheemEventsForSingleAsset] 
	-- Add the parameters for the stored procedure here
		@AssetID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT * 
	FROM rheemevents..RheemEvent a, 
		 rheemevents..RheemEventAsset b
	WHERE b.AssetID=@AssetID and
	      a.RheemEventID = b.RheemEventID

END
GO
