USE [RheemUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetApplicationRoleID]') AND type in (N'FN'))
DROP function [dbo].[GetApplicationRoleID]

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
CREATE FUNCTION [dbo].[GetApplicationRoleID] 
(
	-- Add the parameters for the function here
@ApplicationName varchar(200),
@RoleName varchar(200)
)
RETURNS uniqueidentifier
AS
BEGIN
	-- Declare the return variable here
	DECLARE @returnID as uniqueidentifier

	-- Add the T-SQL statements to compute the return value here
	SET @returnID = (
	select ApplicationRoleID from rheemusers..Application a, RheemUsers..Role r, RheemUsers ..ApplicationRole ar
	   where
	a.ApplicationName = @ApplicationName and 
	a.ApplicationID = ar.ApplicationID and 
	ar.RoleID = r.RoleID and 
	r.RoleName = @RoleName    
	)

	-- Return the result of the function
	RETURN @returnID

END

GO


