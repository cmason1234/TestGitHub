USE [RheemEvents]
GO
/****** Object:  Table [dbo].[RheemEventDetail]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEventDetail](
	[RheemEventDetailID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[ShowSchedule] [ntext] NULL,
	[ShowObjectives] [ntext] NULL,
	[ShowTactics] [ntext] NULL,
	[Sponsorships] [ntext] NULL,
	[AdvertisingSupport] [ntext] NULL,
	[WebsiteSupport] [ntext] NULL,
	[ResultsAndMeasures] [ntext] NULL,
	[AttendanceCriteria] [ntext] NULL,
	[EventMgmtContactOrganizationID] [uniqueidentifier] NULL,
	[EventMgmtContactPersonID] [uniqueidentifier] NULL,
	[EventMgmtContactPhone] [varchar](50) NULL,
	[EventMgmtContactEmail] [varchar](150) NULL,
	[EmployeeEventFloorContactID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EventDetail] PRIMARY KEY CLUSTERED 
(
	[RheemEventDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[RheemEventDetail]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventDetail_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RheemEventDetail] CHECK CONSTRAINT [FK_RheemEventDetail_RheemEvent]
GO
ALTER TABLE [dbo].[RheemEventDetail] ADD  CONSTRAINT [DF_EventDetail_EventDetailID]  DEFAULT (newid()) FOR [RheemEventDetailID]
GO
