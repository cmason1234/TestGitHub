Use [RheemDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_DistributorTag') AND type in (N'U'))
BEGIN

	CREATE TABLE [dbo].[EC_DistributorTag]( 
		[EC_DistributorTagID] [uniqueidentifier] NOT NULL, 
		[GDPClaimYear] [int] NOT NULL, 
		[OrganizationID] [uniqueidentifier] NOT NULL, 
		[TagName] [varchar](50) NOT NULL, 
		[GDPBudget] bit NOT NULL,
		[TCBudget] bit NOT NULL,
	CONSTRAINT [PK_EC_DistributorTag] PRIMARY KEY CLUSTERED 
	( 
		[EC_DistributorTagID] ASC 
	) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON),
	CONSTRAINT [UK_EC_DistributorTag] UNIQUE 
	(
	   [GDPClaimYear], [OrganizationID], [TagName], [GDPBudget], [TCBudget]
	 )
	   ON [PRIMARY] 
	) ON [PRIMARY]

END
GO

-- Copy over the tags (otherDescription) from 2012, 
--  Distinct is required so we don't get duplicate Org, tags.
declare @cnt integer

Select @cnt=COUNT(1) from EC_DistributorTag
IF @cnt = 0
BEGIN
   INSERT EC_DistributorTag (EC_DistributorTagID, GDPClaimYear, OrganizationID, TagName, GDPBudget, TCBudget)
    select NEWID(), '2013', OrganizationID, OtherDescription, 1, 0 from 
        (Select distinct OrganizationID, OtherDescription from EC_ClaimBudget 
       where BudgetYear=2012 and OtherDescription is not null and
        LEN(OtherDescription) <> 0 and GDPBudget=1) a

   INSERT EC_DistributorTag (EC_DistributorTagID, GDPClaimYear, OrganizationID, TagName, GDPBudget, TCBudget)
    select NEWID(), '2013', OrganizationID, OtherDescription, 0, 1 from 
        (select distinct OrganizationID, OtherDescription from EC_ClaimBudget 
       where BudgetYear=2012 and OtherDescription is not null and
        LEN(OtherDescription) <> 0 and TCBudget=1) a
    
END
GO


if NOT EXISTS(select * from sys.columns where Name = N'EC_DistributorTagID'  
            and Object_ID = Object_ID(N'EC_Claims'))
BEGIN
    ALTER TABLE [dbo].[EC_Claims] ADD [EC_DistributorTagID] [uniqueidentifier] NULL
	ALTER TABLE [dbo].[EC_Claims] ADD CONSTRAINT FK_EC_CLaims_DistributorTagID FOREIGN KEY
	    (EC_DistributorTagID) REFERENCES EC_DistributorTag (EC_DistributorTagID)
END
GO



IF NOT EXISTS(select * from sys.columns where Name = N'WHBudget'  
            and Object_ID = Object_ID(N'EC_DistributorTag'))
BEGIN
	ALTER TABLE EC_DistributorTag ADD WHBudget bit NOT NULL DEFAULT 0;
END
GO


IF NOT EXISTS(select * from sys.columns where Name = N'SPBudget'  
            and Object_ID = Object_ID(N'EC_DistributorTag'))
BEGIN
	ALTER TABLE EC_DistributorTag ADD SPBudget bit NOT NULL DEFAULT 0;
END
GO

IF NOT EXISTS(select * from sys.columns where Name = N'PROSTOCKBudget'  
            and Object_ID = Object_ID(N'EC_DistributorTag'))
BEGIN
	ALTER TABLE EC_DistributorTag ADD PROSTOCKBudget bit NOT NULL DEFAULT 0;
END
GO

IF NOT EXISTS(
      SELECT col.name FROM sys.indexes ind INNER JOIN sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id INNER JOIN sys.columns col     ON ic.object_id = col.object_id and ic.column_id = col.column_id 
        WHERE ind.name='UK_EC_DistributorTag' AND ind.object_id = OBJECT_ID('EC_DistributorTag') AND col.name='PROSTOCKBudget'
    )
BEGIN
        ALTER TABLE EC_DistributorTag Drop constraint UK_EC_DistributorTag
		Create Unique Index [UK_EC_DistributorTag] ON
		     EC_DistributorTag (GDPClaimYear, OrganizationID, TagName, GDPBudget, TCBudget, WHBudget, SPBudget, PROSTOCKBudget)
END
GO



