USE [RheemUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LatitudePlusDistance]') AND type in (N'FN'))
DROP function [dbo].[LatitudePlusDistance]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
Create Function [dbo].[LatitudePlusDistance](@StartLatitude Float, @Distance Float) Returns Float
As
Begin
    Return (Select @StartLatitude + Sqrt(@Distance * @Distance / 4766.8999155991))
End
go


