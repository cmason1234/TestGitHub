USE [RheemUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrgBrandList]') AND type in (N'FN'))
DROP function [dbo].[GetOrgBrandList]

/****** Object:  UserDefinedFunction [dbo].[CountQuotes]    Script Date: 05/18/2012 09:52:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetOrgBrandList] 
(
	-- Add the parameters for the function here
  @OrganizationID uniqueidentifier
)
RETURNS varchar(1000)
AS
BEGIN

	declare @brandlist varchar(1000)

	select @brandlist =  COALESCE(@brandlist + ', ', '') + b.BrandName  from 
		OrganizationBrand ob
		inner join RheemDB..Brand b on ob.BrandID=b.BrandID
		WHERE ob.OrganizationID = @OrganizationID

	return @brandlist
END
GO


