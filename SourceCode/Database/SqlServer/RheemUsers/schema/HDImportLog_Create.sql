USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HDImportLog]') AND type in (N'U'))
BEGIN
	CREATE TABLE dbo.HDImportLog( 
		HDImportLogID uniqueidentifier NOT NULL, 
		ImportType varchar(50) NOT NULL,
		Message varchar(1024),
		MsgTime dateTime,
		MsgOrder Integer NOT NULL,
	CONSTRAINT PK_HDImportLog PRIMARY KEY CLUSTERED 
	( 
		HDImportLogID ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	CREATE UNIQUE INDEX IDX1_HDImportLog ON rheemusers..HDImportLog (ImportType, MsgOrder);

END
GO
