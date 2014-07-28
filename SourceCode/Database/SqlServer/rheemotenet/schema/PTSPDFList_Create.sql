USE [rheemotenet]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PTSPDFList]') AND type in (N'U'))
BEGIN

	CREATE TABLE [dbo].[PTSPDFList](
		[PTSPDFListID] [uniqueidentifier] NOT NULL,
		[Directory] varchar(450) Not NULL,
		[FileName] varchar(450) Not Null,
		[FileURL] varchar(900) Not Null,
		[Keywords] varchar(900) Null,
		[Title] varchar(900) Null,
		[FileDateTime] datetime NOT NULL,
		[CreateDateTime__Gen] [datetime] NULL,
		[UpdateDateTime__Gen] [datetime] NULL,
		CONSTRAINT [PK_PTSPDFListID] PRIMARY KEY CLUSTERED 
		(
			[PTSPDFListID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
				ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	Create Unique Index ptspdfList_uqidx1 on PTSPDFList ([Directory], [FileName])
	Create Index ptspdList_idx1 on PTSPDFList ([Keywords])
	Create Index ptspdList_idx2 on PTSPDFList ([Title])

END
GO
