USE [RheemEvents]
GO
/****** Object:  Table [dbo].[Panel]    Script Date: 10/03/2011 15:12:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RheemEventLog]') AND type in (N'U'))
DROP TABLE [dbo].[RheemEventLog]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEventLog](
	[RheemEventLogID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[LogText] [varchar](256) NOT NULL,
	[LogDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RheemEventLogs] PRIMARY KEY CLUSTERED 
(
	[RheemEventLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[RheemEventLog]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventLog_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID])
ON DELETE CASCADE
GO

