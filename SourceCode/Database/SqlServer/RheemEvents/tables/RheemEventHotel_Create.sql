USE [RheemEvents]
GO
/****** Object:  Table [dbo].[RheemEventHotel]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEventHotel](
	[RheemEventHotelID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[HotelID] [uniqueidentifier] NOT NULL,
	[ContactName] [nvarchar](150) NULL,
	[ContactPhone] [varchar](50) NULL,
	[ContactEmail] [varchar](150) NULL,
	[GroupBlock] [nvarchar](50) NULL,
	[Notes] [ntext] NULL,
 CONSTRAINT [PK_RheemEventHotel] PRIMARY KEY CLUSTERED 
(
	[RheemEventHotelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[RheemEventHotel]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventHotel_Hotel] FOREIGN KEY([HotelID])
REFERENCES [dbo].[Hotel] ([HotelID])
GO
ALTER TABLE [dbo].[RheemEventHotel] CHECK CONSTRAINT [FK_RheemEventHotel_Hotel]
GO
ALTER TABLE [dbo].[RheemEventHotel]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventHotel_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RheemEventHotel] CHECK CONSTRAINT [FK_RheemEventHotel_RheemEvent]
GO
ALTER TABLE [dbo].[RheemEventHotel] ADD  CONSTRAINT [DF_RheemEventHotel_RheemEventHotelID]  DEFAULT (newid()) FOR [RheemEventHotelID]
GO
