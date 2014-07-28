USE [WaterHeaterDB]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udfGetCustomerDesc]') AND type in (N'FN'))
DROP function [dbo].[udfGetCustomerDesc]

/****** Object:  UserDefinedFunction [dbo].[udfGetCustomerDesc]    Script Date: 02/14/2013 08:16:50 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE  FUNCTION [dbo].[udfGetCustomerDesc]( @CustName varchar(35),
	@AddrCity varchar(25),
	@AddrLine1 varchar(25),
	@CustNumber varchar(15))
  
RETURNS varchar(100)  AS  
BEGIN 
  DECLARE @ReturnValue varchar(100)

  SET @ReturnValue = RTRIM(@CustName) + ', '
  IF @AddrCity IS NOT NULL
    SET @ReturnValue = @ReturnValue + RTRIM(@AddrCity) + ', '
  IF @AddrLine1 IS NOT NULL
    SET @ReturnValue = @ReturnValue + RTRIM(@AddrLine1) + ' - '
  IF @CustNumber IS NOT NULL
    SET @ReturnValue = @ReturnValue + RTRIM(@CustNumber) 
  RETURN @ReturnValue
END


GO

