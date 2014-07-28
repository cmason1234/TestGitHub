USE [ConsumerContent]
GO
/****** Object:  StoredProcedure [dbo].[SearchContactListsByString]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchContactListsByString
   
   Description:  Selects a record from table 'ContactLists'
   				 And puts values into parameters
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 12:52:25 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContactListsByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE SearchContactListsByString;
		PRINT 'Dropped SearchContactListsByString'
	END
GO

CREATE PROCEDURE [dbo].[SearchContactListsByString]
(
	@searchParam varchar(500)
)
As
BEGIN
	DECLARE @Err Int
	DECLARE @strSql nvarchar(4000)
	
	--//If you don't need all fields, change Select string below
	--//Only get the data you need
	SET @strSql = '	Select 	[ID], [Category], [Contact], [Email]
	FROM [ContactLists]
	WHERE ' +  @searchParam
	
	EXEC sp_executesql @strSql
	
	--//Example (If Fields are known, format like below)
	--IF @prodname IS NOT NULL
	--SELECT @strSql = @strSql + ' ProductName LIKE @prodname'
	
	--EXEC sp_executesql @strSql, N'@prodname varchar(400)',@prodname

	--//do not use exec()
	--EXEC(@strSql)
End
GO
/****** Object:  StoredProcedure [dbo].[SearchContactEmailsByString]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchContactEmailsByString
   
   Description:  Selects a record from table 'ContactEmails'
   				 And puts values into parameters
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContactEmailsByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE SearchContactEmailsByString;
		PRINT 'Dropped SearchContactEmailsByString'
	END
GO

CREATE PROCEDURE [dbo].[SearchContactEmailsByString]
(
	@searchParam varchar(500)
)
As
BEGIN
	DECLARE @Err Int
	DECLARE @strSql nvarchar(4000)
	
	--//If you don't need all fields, change Select string below
	--//Only get the data you need
	SET @strSql = '	Select 	[EntryID], [Topic], [Subtopic], [ToEmail], 
	[PhoneNumber], [PostalCode], [Message], [TimeStamp], [FromEmail], 
	[FromName], [ModelNumber], [SerialNumber], [Country], 
	[PlumberContractorName], [PlumberContractorPhoneNumber],
	CONVERT(varchar, TimeStamp, 101) as thistime
	FROM [ContactEmails]
	WHERE ' +  @searchParam
	
	EXEC sp_executesql @strSql
	
	--//Example (If Fields are known, format like below)
	--IF @prodname IS NOT NULL
	--SELECT @strSql = @strSql + ' ProductName LIKE @prodname'
	
	--EXEC sp_executesql @strSql, N'@prodname varchar(400)',@prodname

	--//do not use exec()
	--EXEC(@strSql)
End
GO
/****** Object:  StoredProcedure [dbo].[SearchContactCategoriesByString]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchContactCategoriesByString
   
   Description:  Selects a record from table 'ContactCategories'
   				 And puts values into parameters
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContactCategoriesByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE SearchContactCategoriesByString;
		PRINT 'Dropped SearchContactCategoriesByString'
	END
GO
CREATE PROCEDURE [dbo].[SearchContactCategoriesByString]
(
	@searchParam varchar(500)
)
As
BEGIN
	DECLARE @Err Int
	DECLARE @strSql nvarchar(4000)
	
	--//If you don't need all fields, change Select string below
	--//Only get the data you need
	SET @strSql = '	Select 	[CategoryID], [Category]
	FROM [ContactCategories]
	WHERE ' +  @searchParam
	
	EXEC sp_executesql @strSql
	
	--//Example (If Fields are known, format like below)
	--IF @prodname IS NOT NULL
	--SELECT @strSql = @strSql + ' ProductName LIKE @prodname'
	
	--EXEC sp_executesql @strSql, N'@prodname varchar(400)',@prodname

	--//do not use exec()
	--EXEC(@strSql)
End
GO
/****** Object:  StoredProcedure [dbo].[InsertContactLists]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    InsertContactLists
   
   Description:  Inserts a record into table 'ContactLists'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 12:52:25 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContactLists') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE InsertContactLists;
		PRINT 'Dropped InsertContactLists'
	END
GO
CREATE PROCEDURE [dbo].[InsertContactLists]
(
	@ID int = null output,
	@Category varchar(250) = null, 
	@Contact varchar(250) = null, 
	@Email varchar(250) = null
)

AS
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	INSERT
	INTO [ContactLists]
	(
		[Category], 
		[Contact], 
		[Email]
	)
	VALUES
	(
		@Category, 
		@Contact, 
		@Email

	)

	SET @Err = @@Error
	SET @ID = @@identity


	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[InsertContactEmails]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    InsertContactEmails
   
   Description:  Inserts a record into table 'ContactEmails'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContactEmails') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE InsertContactEmails;
		PRINT 'Dropped InsertContactEmails'
	END
GO
CREATE PROCEDURE [dbo].[InsertContactEmails]
(
	@EntryID int = null output,
	@Topic nvarchar(250) = null, 
	@Subtopic nvarchar(250) = null, 
	@ToEmail nvarchar(100) = null, 
	@PhoneNumber nvarchar(100) = null, 
	@PostalCode nvarchar(20) = null, 
	@Message nvarchar(max) = null, 
	@TimeStamp datetime, 
	@FromEmail nvarchar(100) = null, 
	@FromName nvarchar(100) = null, 
	@ModelNumber nvarchar(100) = null, 
	@SerialNumber nvarchar(100) = null, 
	@Country nvarchar(100) = null, 
	@PlumberContractorName nvarchar(200) = null, 
	@PlumberContractorPhoneNumber nvarchar(50) = null
)

AS
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	INSERT
	INTO [ContactEmails]
	(
		[Topic], 
		[Subtopic], 
		[ToEmail], 
		[PhoneNumber], 
		[PostalCode], 
		[Message], 
		[TimeStamp], 
		[FromEmail], 
		[FromName], 
		[ModelNumber], 
		[SerialNumber], 
		[Country], 
		[PlumberContractorName], 
		[PlumberContractorPhoneNumber]
	)
	VALUES
	(
		@Topic, 
		@Subtopic, 
		@ToEmail, 
		@PhoneNumber, 
		@PostalCode, 
		@Message, 
		@TimeStamp, 
		@FromEmail, 
		@FromName, 
		@ModelNumber, 
		@SerialNumber, 
		@Country, 
		@PlumberContractorName, 
		@PlumberContractorPhoneNumber

	)

	SET @Err = @@Error
	SET @EntryID = @@identity


	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[InsertContactCategories]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    InsertContactCategories
   
   Description:  Inserts a record into table 'ContactCategories'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:28 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContactCategories') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE InsertContactCategories;
		PRINT 'Dropped InsertContactCategories'
	END
GO
CREATE PROCEDURE [dbo].[InsertContactCategories]
(
	@CategoryID int = null output,
	@Category varchar(250) = null
)

AS
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	INSERT
	INTO [ContactCategories]
	(
			[Category]
	)
	VALUES
	(
			@Category

	)

	SET @Err = @@Error
	SET @CategoryID = @@identity


	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[GetContactListsByID]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetContactListsByID
   
   Description:  Selects record(s) from table 'ContactLists'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 12:52:25 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContactListsByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE GetContactListsByID;
		PRINT 'Dropped GetContactListsByID'
	END
GO
CREATE PROCEDURE [dbo].[GetContactListsByID]
(
	@ID int

)
As
BEGIN
	DECLARE @Err Int

	Select 	[ID], [Category], [Contact], [Email]
	FROM [ContactLists]
	WHERE [ID] = @ID

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[GetContactEmailsByID]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetContactEmailsByID
   
   Description:  Selects record(s) from table 'ContactEmails'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContactEmailsByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE GetContactEmailsByID;
		PRINT 'Dropped GetContactEmailsByID'
	END
GO
CREATE PROCEDURE [dbo].[GetContactEmailsByID]
(
	@EntryID int

)
As
BEGIN
	DECLARE @Err Int

	Select 	[EntryID], [Topic], [Subtopic], [ToEmail], [PhoneNumber], [PostalCode], [Message], [TimeStamp], [FromEmail], [FromName], [ModelNumber], [SerialNumber], [Country], [PlumberContractorName], [PlumberContractorPhoneNumber]
	FROM [ContactEmails]
	WHERE [EntryID] = @EntryID

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[GetContactCategoriesByID]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetContactCategoriesByID
   
   Description:  Selects record(s) from table 'ContactCategories'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContactCategoriesByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE GetContactCategoriesByID;
		PRINT 'Dropped GetContactCategoriesByID'
	END
GO
CREATE PROCEDURE [dbo].[GetContactCategoriesByID]
(
	@CategoryID int

)
As
BEGIN
	DECLARE @Err Int

	Select 	[CategoryID], [Category]
	FROM [ContactCategories]
	WHERE [CategoryID] = @CategoryID

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[DeleteContactLists]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeleteContactLists
   
   Description:  Deletes a record from table 'ContactLists'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 12:52:25 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContactLists') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE DeleteContactLists;
		PRINT 'Dropped DeleteContactLists'
	END
GO
CREATE PROCEDURE [dbo].[DeleteContactLists]
(
	@ID int

)
As
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContactLists] 
	WHERE [ID] = @ID
		

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[DeleteContactEmails]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeleteContactEmails
   
   Description:  Deletes a record from table 'ContactEmails'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContactEmails') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE DeleteContactEmails;
		PRINT 'Dropped DeleteContactEmails'
	END
GO
CREATE PROCEDURE [dbo].[DeleteContactEmails]
(
	@EntryID int

)
As
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContactEmails] 
	WHERE [EntryID] = @EntryID
		

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[DeleteContactCategories]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeleteContactCategories
   
   Description:  Deletes a record from table 'ContactCategories'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContactCategories') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE DeleteContactCategories;
		PRINT 'Dropped DeleteContactCategories'
	END
GO
CREATE PROCEDURE [dbo].[DeleteContactCategories]
(
	@CategoryID int

)
As
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContactCategories] 
	WHERE [CategoryID] = @CategoryID
		

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[UpdateContactLists]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    UpdateContactLists
   
   Description:  Updates a record In table 'ContactLists'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 12:52:25 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContactLists') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE UpdateContactLists;
		PRINT 'Dropped UpdateContactLists'
	END
GO
CREATE PROCEDURE [dbo].[UpdateContactLists]
(
	@ID int, 
	@Category varchar(250), 
	@Contact varchar(250), 
	@Email varchar(250)

)
As
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContactLists]
	SET
	[Category] = @Category, 
	[Contact] = @Contact, 
	[Email] = @Email

	WHERE [ID] = @ID

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[UpdateContactEmails]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    UpdateContactEmails
   
   Description:  Updates a record In table 'ContactEmails'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContactEmails') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE UpdateContactEmails;
		PRINT 'Dropped UpdateContactEmails'
	END
GO
CREATE PROCEDURE [dbo].[UpdateContactEmails]
(
	@EntryID int, 
	@Topic nvarchar(250) = null, 
	@Subtopic nvarchar(250) = null, 
	@ToEmail nvarchar(100) = null, 
	@PhoneNumber nvarchar(100) = null, 
	@PostalCode nvarchar(20) = null, 
	@Message nvarchar(max) = null, 
	@TimeStamp datetime, 
	@FromEmail nvarchar(100) = null, 
	@FromName nvarchar(100) = null, 
	@ModelNumber nvarchar(100) = null, 
	@SerialNumber nvarchar(100) = null, 
	@Country nvarchar(100) = null, 
	@PlumberContractorName nvarchar(200) = null, 
	@PlumberContractorPhoneNumber nvarchar(50) = null

)
As
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContactEmails]
	SET
	[Topic] = @Topic, 
	[Subtopic] = @Subtopic, 
	[ToEmail] = @ToEmail, 
	[PhoneNumber] = @PhoneNumber, 
	[PostalCode] = @PostalCode, 
	[Message] = @Message, 
	[TimeStamp] = @TimeStamp, 
	[FromEmail] = @FromEmail, 
	[FromName] = @FromName, 
	[ModelNumber] = @ModelNumber, 
	[SerialNumber] = @SerialNumber, 
	[Country] = @Country, 
	[PlumberContractorName] = @PlumberContractorName, 
	[PlumberContractorPhoneNumber] = @PlumberContractorPhoneNumber

	WHERE [EntryID] = @EntryID

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[UpdateContactCategories]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    UpdateContactCategories
   
   Description:  Updates a record In table 'ContactCategories'
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 11:29:29 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContactCategories') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE UpdateContactCategories;
		PRINT 'Dropped UpdateContactCategories'
	END
GO
CREATE PROCEDURE [dbo].[UpdateContactCategories]
(
	@CategoryID int, 
	@Category varchar(250)

)
As
SET NOCOUNT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContactCategories]
	SET
	[Category] = @Category

	WHERE [CategoryID] = @CategoryID

	Set @Err = @@Error

	RETURN @Err
End
GO
/****** Object:  StoredProcedure [dbo].[SearchContactListsByStringForSubTopic]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchContactListsByString
   
   Description:  Selects a record from table 'ContactLists'
   				 And puts values into parameters
   
   AUTHOR:       Rheem, Brian White - 9/13/2010 12:52:25 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContactListsByStringForSubTopic') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE SearchContactListsByStringForSubTopic;
		PRINT 'Dropped SearchContactListsByStringForSubTopic'
	END
GO
CREATE PROCEDURE [dbo].[SearchContactListsByStringForSubTopic]
(
	@Category varchar(500)
)
As
BEGIN
	DECLARE @Err Int
	SET NOCOUNT ON
	
	SELECT [ID], [Category], [Contact], [Email]
	FROM [ContactLists]
	WHERE Category = @Category
	ORDER BY Contact
		
End
GO
/****** Object:  StoredProcedure [dbo].[ReportGetWebContacts]    Script Date: 12/20/2010 09:15:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('ReportGetWebContacts') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE ReportGetWebContacts;
		PRINT 'Dropped ReportGetWebContacts'
	END
GO
CREATE PROCEDURE [dbo].[ReportGetWebContacts]
(
	@BeginDate datetime,
	@EndDate datetime,
	@Topic varchar(50),
	@DayWeekMonth varchar(50)
)
As
BEGIN
	DECLARE @Err Int
	
	If @DayWeekMonth = 'Days'
	Begin
	
		If @Topic = '0' 
		Begin
			SELECT DISTINCT Topic, CONVERT(varchar, TimeStamp, 101) AS ThisDate, dbo.CountDays(CONVERT(varchar, TimeStamp, 101), CONVERT(varchar, TimeStamp, 101), Topic) AS thisCount
			FROM ContactEmails
			WHERE (TimeStamp BETWEEN @BeginDate AND @EndDate) 
			
		End
		Else
		Begin
			SELECT DISTINCT Topic, CONVERT(varchar, TimeStamp, 101) AS ThisDate, dbo.CountDays(CONVERT(varchar, TimeStamp, 101), CONVERT(varchar, TimeStamp, 101), Topic) AS thisCount
			FROM ContactEmails
			WHERE (TimeStamp BETWEEN @BeginDate AND @EndDate) 		
			AND Topic = @Topic	
		End
		
	End
	
	If @DayWeekMonth = 'Weeks'
	Begin
	
		If @Topic = '0' 
		Begin
			SELECT DISTINCT Topic, DATEPART(wk, TimeStamp) AS ThisDate, dbo.CountDaysByWeeks(DATEPART(wk, TimeStamp), DATEPART(year, TimeStamp), Topic) AS thisCount
			FROM ContactEmails
			WHERE (TimeStamp BETWEEN @BeginDate AND @EndDate) 			
			and (DATEPART(wk, TimeStamp) >= DATEPART(wk, @BeginDate)
			and DATEPART(wk, TimeStamp) <= DATEPART(wk, @EndDate))
		End
		Else
		Begin
			SELECT DISTINCT Topic, DATEPART(wk, TimeStamp) AS ThisDate, dbo.CountDaysByWeeks(DATEPART(wk, TimeStamp), DATEPART(year, TimeStamp), Topic) AS thisCount
			FROM ContactEmails
			WHERE (TimeStamp BETWEEN @BeginDate AND @EndDate) 
			AND Topic = @Topic
			and (DATEPART(wk, TimeStamp) >= DATEPART(wk, @BeginDate)
			and DATEPART(wk, TimeStamp) <= DATEPART(wk, @EndDate))
		End
			
	End
	
	If @DayWeekMonth = 'Months'
	Begin
	
		If @Topic = '0' 
		Begin
			SELECT DISTINCT Topic, DATEPART(m, TimeStamp) AS ThisDate, dbo.CountDaysByMonths(DATEPART(m, TimeStamp), DATEPART(year, TimeStamp), Topic) AS thisCount
			FROM ContactEmails
			WHERE (TimeStamp BETWEEN @BeginDate AND @EndDate) 
			and (DATEPART(m, TimeStamp) >= DATEPART(m, @BeginDate)
			and DATEPART(m, TimeStamp) <= DATEPART(m, @EndDate))
		End 
		Else
		Begin
			SELECT DISTINCT Topic, DATEPART(m, TimeStamp) AS ThisDate, dbo.CountDaysByMonths(DATEPART(m, TimeStamp), DATEPART(year, TimeStamp), Topic) AS thisCount
			FROM ContactEmails
			WHERE (TimeStamp BETWEEN @BeginDate AND @EndDate) 
			AND Topic = @Topic
			and (DATEPART(m, TimeStamp) >= DATEPART(m, @BeginDate)
			and DATEPART(m, TimeStamp) <= DATEPART(m, @EndDate))
		End
	
	End
	
End
GO
