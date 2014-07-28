USE RheemUsers
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Parts_ComponentDoc') AND type in (N'U'))
BEGIN

	CREATE TABLE Parts_ComponentDoc(
		Parts_ComponentDocID int NOT NULL,
		ComponentNumber varchar(50) NOT NULL,
		URL varchar(2350) NOT NULL,
		isDoc bit NOT NULL,
		Brand varchar(5) NOT NULL,
		HiRes bit NOT NULL,
		CONSTRAINT PK_Parts_ComponentDoc PRIMARY KEY CLUSTERED 
		(
			Parts_ComponentDocID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'Parts_ComponentDoc_idx1' AND object_id = OBJECT_ID('Parts_ComponentDoc'))
BEGIN
   CREATE NONCLUSTERED INDEX Parts_ComponentDoc_idx1 ON Parts_ComponentDoc (ComponentNumber)
END
GO


