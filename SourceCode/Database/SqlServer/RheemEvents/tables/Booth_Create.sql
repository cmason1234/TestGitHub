USE [RheemEvents]
GO
/****** Object:  Table [dbo].[Booth]    Script Date: 11/17/2010 13:46:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Booth]') AND type in (N'U'))
DROP TABLE [dbo].[Booth]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Booth](
	[BoothID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[BoothType] [varchar](50) NOT NULL,
	[BoothNum] [nvarchar](50) NULL,
	[BoothLocation] [nvarchar](250) NULL,
	[Width] [int] NOT NULL,
	[Length] [int] NOT NULL,
	[MaxCapacity] [int] NOT NULL,
	[HasPower] [int] NOT NULL,
	[HasInternet] [int] NOT NULL,
 CONSTRAINT [PK_Booth] PRIMARY KEY CLUSTERED 
(
	[BoothID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Booth, Tent, Suite, Table, Other' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Booth', @level2type=N'COLUMN',@level2name=N'BoothType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = no, 1 = wired, 2 = wireless' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Booth', @level2type=N'COLUMN',@level2name=N'HasInternet'
GO
ALTER TABLE [dbo].[Booth]  WITH CHECK ADD  CONSTRAINT [FK_Booth_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Booth] CHECK CONSTRAINT [FK_Booth_RheemEvent]
GO
ALTER TABLE [dbo].[Booth] ADD  CONSTRAINT [DF_Booth_BoothID]  DEFAULT (newid()) FOR [BoothID]
GO
ALTER TABLE [dbo].[Booth] ADD  CONSTRAINT [DF_Booth_Width]  DEFAULT ((0)) FOR [Width]
GO
ALTER TABLE [dbo].[Booth] ADD  CONSTRAINT [DF_Booth_Length]  DEFAULT ((0)) FOR [Length]
GO
ALTER TABLE [dbo].[Booth] ADD  CONSTRAINT [DF_Booth_MaxCapacity]  DEFAULT ((0)) FOR [MaxCapacity]
GO
ALTER TABLE [dbo].[Booth] ADD  CONSTRAINT [DF_Booth_HasPower]  DEFAULT ((0)) FOR [HasPower]
GO
ALTER TABLE [dbo].[Booth] ADD  CONSTRAINT [DF_Booth_HasInternet]  DEFAULT ((0)) FOR [HasInternet]
GO

