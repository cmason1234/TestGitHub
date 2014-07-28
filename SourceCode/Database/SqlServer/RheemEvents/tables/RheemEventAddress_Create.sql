USE [RheemEvents]
GO
/****** Object:  Table [dbo].[RheemEventAddress]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEventAddress](
	[RheemEventAddressID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[AddressType] [varchar](50) NULL,
	[LocationName] [nvarchar](350) NULL,
	[Address1] [nvarchar](250) NULL,
	[Address2] [nvarchar](250) NULL,
	[City] [nvarchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zip] [varchar](10) NULL,
	[Country] [varchar](50) NULL,
 CONSTRAINT [PK_RheemEventAddress] PRIMARY KEY CLUSTERED 
(
	[RheemEventAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[RheemEventAddress]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventAddress_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID]) ON DELETE CASCADE 
GO
ALTER TABLE [dbo].[RheemEventAddress] CHECK CONSTRAINT [FK_RheemEventAddress_RheemEvent]
GO
ALTER TABLE [dbo].[RheemEventAddress] ADD  CONSTRAINT [DF_RheemEventAddress_RheemEventAddressID]  DEFAULT (newid()) FOR [RheemEventAddressID]
GO
