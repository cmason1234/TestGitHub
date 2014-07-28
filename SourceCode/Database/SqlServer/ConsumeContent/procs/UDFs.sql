USE [ConsumerContent]
GO
/****** Object:  UserDefinedFunction [dbo].[CountDaysByWeeks]    Script Date: 12/20/2010 09:17:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountDaysByWeeks]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	BEGIN
		DROP Function CountDaysByWeeks;
		PRINT 'Dropped CountDaysByWeeks'
	END
GO

CREATE FUNCTION [dbo].[CountDaysByWeeks]
(
	@WeekNum int,
	@YearNum int,
	@Topic varchar(50)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @dCount Int

	-- Add the T-SQL statements to compute the return value here
	Select @dCount = COUNT(TimeStamp)
		from ContactEmails
		where Topic = @Topic
		and DATEPART(wk, TimeStamp) = @WeekNum
		and DATEPART(YEAR, TimeStamp) = @YearNum

	-- Return the result of the function
	RETURN @dCount

END
GO
/****** Object:  UserDefinedFunction [dbo].[CountDaysByMonths]    Script Date: 12/20/2010 09:17:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountDaysByMonths]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	BEGIN
		DROP Function CountDaysByMonths;
		PRINT 'Dropped CountDaysByMonths'
	END
GO
CREATE FUNCTION [dbo].[CountDaysByMonths]
(
	@MonthNum int,
	@YearNum int,
	@Topic varchar(50)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @dCount Int

	-- Add the T-SQL statements to compute the return value here
	Select @dCount = COUNT(TimeStamp)
		from ContactEmails
		where Topic = @Topic
		and DATEPART(m, TimeStamp) = @MonthNum
		and DATEPART(YEAR, TimeStamp) = @YearNum

	-- Return the result of the function
	RETURN @dCount

END
GO
/****** Object:  UserDefinedFunction [dbo].[CountDays]    Script Date: 12/20/2010 09:17:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountDays]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	BEGIN
		DROP Function CountDays;
		PRINT 'Dropped CountDays'
	END
GO
CREATE FUNCTION [dbo].[CountDays] 
(
	@BeginDate datetime,
	@EndDate datetime,
	@Topic varchar(50)
)
RETURNS Int
AS
BEGIN

	DECLARE @dCount Int
	
	Declare @tDateBegin datetime
	set @tDateBegin = @BeginDate + ' 12:00:01 AM'
	
	Declare @tDateEnd datetime
	set @tDateEnd = @EndDate + ' 11:59:59 PM'

		
	Select @dCount = COUNT(TimeStamp)
	from ContactEmails
	where TimeStamp between @tDateBegin and @tDateEnd
	And Topic = @Topic

	
	-- Return the result of the function
	RETURN @dCount

END
GO
