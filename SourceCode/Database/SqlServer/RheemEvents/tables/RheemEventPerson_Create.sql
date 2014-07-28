USE [RheemEvents]
GO
/****** Object:  Table [dbo].[RheemEventPerson]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEventPerson](
	[RheemEventPersonID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[PersonID] [uniqueidentifier] NOT NULL,
	[PersonRole] [varchar](50) NULL,
	[ShirtSize] [varchar](50) NULL,
	[PantSize] [varchar](50) NULL,
	[ShoeSize] [varchar](50) NULL,
 CONSTRAINT [PK_RheemEventPerson] PRIMARY KEY CLUSTERED 
(
	[RheemEventPersonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ambassador, Host, IT, Guest, Contractor, Distributor, ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RheemEventPerson', @level2type=N'COLUMN',@level2name=N'PersonRole'
GO
ALTER TABLE [dbo].[RheemEventPerson]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventPerson_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RheemEventPerson] CHECK CONSTRAINT [FK_RheemEventPerson_RheemEvent]
GO
ALTER TABLE [dbo].[RheemEventPerson] ADD  CONSTRAINT [DF_RheemEventPerson_RheemEventPersonID]  DEFAULT (newid()) FOR [RheemEventPersonID]
GO
