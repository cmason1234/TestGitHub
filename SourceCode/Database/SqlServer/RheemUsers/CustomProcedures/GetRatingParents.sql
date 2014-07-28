USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRatingParents]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRatingParents]
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
CREATE PROCEDURE [dbo].[GetRatingParents] 
	-- Add the parameters for the stored procedure here
	@RatingParentName varchar(100)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT RatingParentID,RatingParentName,a.DivisionID,
		   DivisionName,BrandName,a.BrandID,a.BusinessUnitID,
		   BusinessUnitName,IsLive,RankType
	FROM rheemusers..RatingParent a
	LEFT JOIN rheemusers..Division b ON a.DivisionID=b.DivisionID
	LEFT JOIN rheemdb..Brand c ON a.BrandID=c.BrandID
	LEFT JOIN rheemusers..BusinessUnit d ON a.BusinessUnitID=d.BusinessUnitID
	WHERE (LEN(@RatingParentName)=0 OR RatingParentName like '%' + @RatingParentName + '%')

END
GO
