﻿USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTotalWeightForOneRatingParent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTotalWeightForOneRatingParent]
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
CREATE PROCEDURE [dbo].[GetTotalWeightForOneRatingParent] 
    -- Add the parameters for the stored procedure here
    @RatingParentID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT SUM(a.weight) AS TotalWeight
    FROM rheemusers..RatingCategory a
    LEFT JOIN rheemusers..RatingParent b ON a.RatingParentID=b.RatingParentID
    WHERE b.RatingParentID=@RatingParentID

END
GO
