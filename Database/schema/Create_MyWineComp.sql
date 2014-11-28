USE mywinecompetition
GO

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[EnvironmentTable]') AND type in (N'U'))
BEGIN
	CREATE TABLE EnvironmentTable(
		EnvironmentTableID int NOT NULL IDENTITY  ( 1 , 1 ) Primary Key,
		EnvironmentVariableName varchar(256) NOT NULL CONSTRAINT
			  EnvTable_UK1 Unique,
		EnvironmentVariableValue varchar(1024) NOT NULL
	) ON [PRIMARY]
END
GO

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[MenuCategory]') AND type in (N'U'))
BEGIN
	CREATE TABLE MenuCategory (
	  MenuCategoryId int NOT NULL IDENTITY  ( 1 , 1 ) Primary Key,
	  MenuCategoryName varchar(15) NOT NULL,
	  MenuCategoryDisplayOrder int NOT NULL
	) ON [PRIMARY]
END
GO

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[MenuItem]') AND type in (N'U'))
BEGIN
	CREATE TABLE MenuItem (
	  MenuItemId int NOT NULL IDENTITY  ( 1 , 1 ) Primary Key,
	  MenuItemName varchar(15) NOT NULL,
	  MenuCategoryId int NOT NULL,
	  MenuItemDisplayOrder int NOT NULL,
	  OnClickText varchar(300) DEFAULT NULL,
	  CONSTRAINT UK1_MenuItem UNIQUE  (MenuItemName,MenuCategoryId),
	  CONSTRAINT MenuItem_fk1 FOREIGN KEY (MenuCategoryId) 
		REFERENCES MenuCategory (MenuCategoryId) ON DELETE CASCADE 
		ON UPDATE NO ACTION
	) ON [PRIMARY]
END
GO

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
BEGIN
	CREATE TABLE Person(
		PersonID int NOT NULL IDENTITY  (1, 1) Primary Key,
		Username varchar(50) NULL,
		FirstName varchar(50) NOT NULL,
		MiddleName varchar(50) NULL,
		LastName varchar(50) NOT NULL,
		EmailAddress varchar(50) NULL,
		EncryptedPassword varchar(50) NULL,
		PasswordSeed varchar(50) NULL,
		PasswordDate datetime NULL
	) ON [PRIMARY] 
	CREATE UNIQUE INDEX Person_Idx1 ON Person(Username)
END
GO


IF NOT EXISTS (SELECT * FROM sys.objects
   WHERE object_id = OBJECT_ID(N'[dbo].[Competition]') and type in (N'U'))
BEGIN
   Create Table Competition (
     CompetitionId int NOT NULL IDENTITY  ( 1 , 1 ) Primary Key,
	 MonthlyCompetition bit Not Null Default 1,
	 CompetitionName varchar(512) Not Null,
	 Year integer Not NULL,
	 Month varchar(125)
   )
END
GO

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[WineEntry]') AND type in (N'U'))
BEGIN
	Create Table WineEntry (
	  WineEntryID int NOT NULL IDENTITY  ( 1 , 1 ) Primary Key,
	  CompetitionID INT Not Null,
	  EntryID INT Not Null,
	  WineName varchar(256) Null,
	  EntrantName varchar(256) Null,
  	  CategoryName varchar(512) NULL,
	  TableNum INT NULL,
	  FlightNum INT Null,
	  SeqNum Int Null,
	  AvgScore float,
	  MedalColor varchar(512),
 	  CONSTRAINT wineentry_fk1 FOREIGN KEY (CompetitionId)
        	  REFERENCES Competition (CompetitionId) on delete cascade,
      Constraint wineEntry_uk1 Unique (CompetitionID, EntryID)
	) ON [PRIMARY]
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'CatNum'  
            and Object_ID = Object_ID(N'WineEntry'))
BEGIN
			ALTER TABLE WineEntry ADD CatNum varchar(20) Null,
END
GO

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[WineScoring]') AND type in (N'U'))
BEGIN
	CREATE TABLE WineScoring (
	  WineScoringID int NOT NULL IDENTITY  ( 1 , 1 ) Primary Key,
	  WineEntryId INT NOT NULL,
	  EnteredPersonID INT NOT NULL,
	  JudgeNum INT NULL,
	  JudgeInitials varchar(25) NULL,
	  Clarity FLOAT NOT NULL DEFAULT 0,
	  Color FLOAT NOT NULL DEFAULT 0,
	  Aroma FLOAT NOT NULL DEFAULT 0,
	  Ta FLOAT NOT NULL DEFAULT 0,
	  Texture FLOAT NOT NULL DEFAULT 0,
	  Flavor FLOAT NOT NULL DEFAULT 0,
	  Bitterness FLOAT NOT NULL DEFAULT 0,
	  Finish FLOAT NOT NULL DEFAULT 0,
	  Quality FLOAT NOT NULL DEFAULT 0,
	  JudgeTotal FLOAT NOT NULL DEFAULT 0,
	  Score FLOAT NOT NULL DEFAULT 0,
	  CONSTRAINT winescoring_fk1 FOREIGN KEY (WineEntryId)
        	  REFERENCES WineEntry (WineEntryId) on delete cascade
	) ON [PRIMARY]
END
GO

IF NOT EXISTS(SELECT * FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[winescoring_fk2]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[WineScoring]'))
BEGIN
	ALTER TABLE WineScoring ADD CONSTRAINT winescoring_fk2 FOREIGN KEY (EnteredPersonID) 
    REFERENCES Person (PersonID) 
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'ValidatedPersonID'  
            and Object_ID = Object_ID(N'WineScoring'))
BEGIN
			ALTER TABLE WineScoring ADD ValidatedPersonID INT NULL
END
GO



IF NOT EXISTS(SELECT * FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[winescoring_fk3]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[WineScoring]'))
BEGIN
	ALTER TABLE WineScoring ADD CONSTRAINT winescoring_fk3 FOREIGN KEY (ValidatedPersonID) 
    REFERENCES Person (PersonID) 
END
GO
