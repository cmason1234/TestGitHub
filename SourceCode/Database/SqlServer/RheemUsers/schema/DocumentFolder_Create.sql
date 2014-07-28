USE RheemUsers
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DocumentFolder') AND type in (N'U'))
BEGIN

	CREATE TABLE DocumentFolder(
		DocumentFolderID uniqueidentifier NOT NULL,
		FolderName varchar(100) NULL,
		ParentDocumentFolderID uniqueidentifier NULL,
	 CONSTRAINT PK_DocumentFolder PRIMARY KEY CLUSTERED 
	(
		DocumentFolderID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	insert into DocumentFolder (DocumentFolderID, FolderName, ParentDocumentFolderID) (select NewID(), 'Root', '00000000-0000-0000-0000-000000000000')
END
GO

if NOT exists (SELECT * FROM sys.indexes WHERE name='IDX_DF_FolderName' AND object_id = OBJECT_ID('DocumentFolder'))
   CREATE UNIQUE NONCLUSTERED INDEX IDX_DF_FolderName ON 
     dbo.DocumentFolder(FolderName) ON [PRIMARY]
