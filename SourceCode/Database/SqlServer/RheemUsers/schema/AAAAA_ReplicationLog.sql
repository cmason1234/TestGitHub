USE RheemUsers

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ReplicationLog') AND type in (N'U'))
BEGIN

	CREATE TABLE ReplicationLog(
	    ReplicationLogID uniqueIdentifier not Null default newid(),
		ReplicationLogNumber int IDENTITY(1,1)  NOT NULL,
		TypeName varchar(50) NOT NULL,
		TableName varchar(255) NOT NULL,
		DbName varchar(255) NOT NULL,
		PKID UniqueIdentifier NOT NULL,
		CreateDateTime__Gen datetime NOT Null default sysdatetime(),
		UpdateDateTime__Gen datetime NOT Null default sysdatetime(),
	 CONSTRAINT PK_RepLog PRIMARY KEY CLUSTERED 
	(
		ReplicationLogID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

END
GO
