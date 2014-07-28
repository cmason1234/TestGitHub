USE [RheemDB]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPostalCodeCityList]') AND type in (N'FN'))
DROP function [dbo].[GetPostalCodeCityList]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetPostalCodeCityList] 
(
	-- Add the parameters for the function here
  @postalCodeIn nvarchar(100)
)
RETURNS varchar(4000)
AS
BEGIN

	declare @citylist varchar(4000)

	select @citylist = COALESCE(@citylist + ', ', '') + City  from 
		PostalCode 
		WHERE postalCode = @postalCodeIn

	return @citylist
END
GO
