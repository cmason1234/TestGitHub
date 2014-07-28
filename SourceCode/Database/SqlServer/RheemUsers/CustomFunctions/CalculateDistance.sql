USE [RheemUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CalculateDistance]') AND type in (N'FN'))
DROP function [dbo].[CalculateDistance]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE Function [dbo].[CalculateDistance]
    (@long1 Decimal(8,5),
    @lat1   Decimal(8,5),
    @long2  Decimal(8,5),
    @lat2   Decimal(8,5))
Returns Float
As
Begin
Declare @R Float(8);
      Declare @dLat Float(18);
      Declare @dLon Float(18);
      Declare @a Float(18);
      Declare @c Float(18);
      Declare @d Float(18);

      Set @dLat = Radians(@lat2 - @lat1);

      Set @dLon = Radians(@long2 - @long1);

      Set @a = Sin(@dLat / 2) 
                 * Sin(@dLat / 2) 
                 + Cos(Radians(@lat1))
                 * Cos(Radians(@lat2)) 
                 * Sin(@dLon / 2) 
                 * Sin(@dLon / 2);
      Set @c = 2 * Asin(Min(Sqrt(@a)));

      Set @d = 3956.55 * @c;
      Return @d; 
 
End
go


