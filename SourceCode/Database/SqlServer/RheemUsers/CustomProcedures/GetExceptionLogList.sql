USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetExceptionLogList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetExceptionLogList]
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
CREATE PROCEDURE [dbo].[GetExceptionLogList] 
    -- Add the parameters for the stored procedure here
    @UserName varchar(50),
	@StartDate datetime,
	@Fatal bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT ExceptionLogID
	    ,ErrDateTime
	    ,ErrMessage
    	,ErrStack
	    ,ErrSource
	    ,ErrPage
		,ErrFirstLineNumber
		,FatalBit
		,IP_Addr
	    ,ISNULL(Username, 'No User Name') AS UserName
		,el.PersonID
	  FROM ExceptionLog el
	  LEFT OUTER JOIN Person p ON el.PersonID = p.PersonID
	  WHERE p.Username like ISNULL(@UserName, '%') and
	        el.ErrDateTime > @StartDate and
			(@Fatal is Null or @Fatal = FatalBit)
	ORDER BY ErrDateTime DESC

END
GO
