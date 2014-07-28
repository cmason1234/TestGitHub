USE [rheemevents]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHotels]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetHotels]
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
CREATE PROCEDURE [dbo].[GetHotels] 
	-- Add the parameters for the stored procedure here
	@HotelName nvarchar(250),
	@City varchar(50),
	@State varchar(3)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT a.HotelID,a.HotelName,a.Phone,a.Fax,a.WebAddress,a.Description,
		   b.AddressLine1, b.AddressLine2, b.City, b.State, b.PostalCode, b.Country 
	FROM rheemevents..Hotel a, 
		 rheemusers..Address b
	WHERE a.HotelName like @HotelName and
		  b.City like @City and
		  b.State like @State and
		  a.AddressID = b.AddressID
	ORDER BY a.HotelName

END
GO
