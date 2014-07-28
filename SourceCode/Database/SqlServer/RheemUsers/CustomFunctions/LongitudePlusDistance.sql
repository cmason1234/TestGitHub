USE [RheemUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LongitudePlusDistance]') AND type in (N'FN'))
DROP function [dbo].[LongitudePlusDistance]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
Create Function [dbo].[LongitudePlusDistance]
    (@StartLongitude Float,
    @StartLatitude Float,
    @Distance Float)
Returns Float
AS
Begin
    Return (Select @StartLongitude + Sqrt(@Distance * @Distance / (4784.39411916406 * Cos(2 * @StartLatitude / 114.591559026165) * Cos(2 * @StartLatitude / 114.591559026165))))
End
go


