USE [rheemusers]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuApplicationRoleIDs]') AND type in (N'P', N'PC'))
DROP procedure [dbo].[GetMenuApplicationRoleIDs]
GO


/****** Object:  UserDefinedFunction [dbo].[GetApplicationRoleID]    Script Date: 05/17/2012 12:59:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE procedure [dbo].[GetMenuApplicationRoleIDs] 
(
	-- Add the parameters for the function here
	@MenuID uniqueidentifier
)

AS
BEGIN
	select ApplicationRoleID from MenuApplicationRole
	   where MenuID = @MenuID

END


GO


