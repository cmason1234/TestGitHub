USE [RheemEvents]
GO
/****** Object:  Table [dbo].[RheemEvent]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEvent](
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[EventType] [varchar](50) NULL,
	[EventSubType] [varchar](50) NULL,
	[EventStatus] [varchar](50) NULL,
	[Title] [nvarchar](350) NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[SetupDate] [datetime] NULL,
	[RequestedBy] [uniqueidentifier] NOT NULL,
	[Author] [uniqueidentifier] NOT NULL,
	[RequestedDate] [datetime] NOT NULL,
	[RequestedNotes] [nvarchar](500) NULL,
	[MaxGuests] [int] NOT NULL,
	[GuestCost] [money] NULL,
	[TSManagerApprovalBy] [uniqueidentifier] NULL,
	[TSManagerApprovalDate] [datetime] NULL,
	[GMApprovalBy] [uniqueidentifier] NULL,
	[GMApprovalDate] [datetime] NULL,
	[GeneralEventInfo] [text] NULL,
	[AudienceContractors] [bit] NULL,
	[AudiencePlumbers] [bit] NULL,
	[AudienceHVACDistributors] [bit] NULL,
	[AudiencePlumbingDistributors] [bit] NULL,
	[AudienceRetail] [bit] NULL,
	[AudienceUtilities] [bit] NULL,
	[AudienceConsumer] [bit] NULL,
	[AudienceOther] [bit] NULL,
	[AudienceOtherDesc] [varchar](250) NULL,
	[ColorForCalendar] [varchar](7) NULL,	
 CONSTRAINT [PK_RheemEvent] PRIMARY KEY CLUSTERED 
(
	[RheemEventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tradeshow, Race' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RheemEvent', @level2type=N'COLUMN',@level2name=N'EventType'
GO
ALTER TABLE [dbo].[RheemEvent] ADD  CONSTRAINT [DF_RheemEvent_MaxGuests]  DEFAULT ((0)) FOR [MaxGuests]
GO
ALTER TABLE [dbo].[RheemEvent] ADD  CONSTRAINT [DF_RheemEvent_GuestCost]  DEFAULT ((0)) FOR [GuestCost]
GO
