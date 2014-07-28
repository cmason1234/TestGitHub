USE [RheemEvents]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RheemEventCollateral_Collateral]') AND parent_object_id = OBJECT_ID(N'[dbo].[RheemEventCollateral]'))
ALTER TABLE [dbo].[RheemEventCollateral] DROP CONSTRAINT [FK_RheemEventCollateral_Collateral]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RheemEventCollateral_RheemEvent]') AND parent_object_id = OBJECT_ID(N'[dbo].[RheemEventCollateral]'))
ALTER TABLE [dbo].[RheemEventCollateral] DROP CONSTRAINT [FK_RheemEventCollateral_RheemEvent]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_RheemEventCollateral_RheemEventCollateralID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RheemEventCollateral] DROP CONSTRAINT [DF_RheemEventCollateral_RheemEventCollateralID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_RheemEventCollateral_Quantity]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RheemEventCollateral] DROP CONSTRAINT [DF_RheemEventCollateral_Quantity]
END

GO

/****** Object:  Table [dbo].[RheemEventCollateral]    Script Date: 12/03/2010 14:47:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RheemEventCollateral]') AND type in (N'U'))
DROP TABLE [dbo].[RheemEventCollateral]
GO

/****** Object:  Table [dbo].[RheemEventCollateral]    Script Date: 12/03/2010 14:47:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[RheemEventCollateral](
	[RheemEventCollateralID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[CollateralID] [uniqueidentifier] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ItemCost] [money] NULL,
	[TotalCost] [money] NULL,
	[RequestedBy] [uniqueidentifier] NOT NULL,
	[RequestedDate] [smalldatetime] NULL,
	[RequestedNotes] [nvarchar](500) NULL,
	[IsApproved] [varchar](50) NULL,
	[ApprovedBy] [uniqueidentifier] NOT NULL,
	[ApprovedDate] [smalldatetime] NULL,
 CONSTRAINT [PK_RheemEventCollateral] PRIMARY KEY CLUSTERED 
(
	[RheemEventCollateralID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[RheemEventCollateral]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventCollateral_Collateral] FOREIGN KEY([CollateralID])
REFERENCES [dbo].[Collateral] ([CollateralID])
GO

ALTER TABLE [dbo].[RheemEventCollateral] CHECK CONSTRAINT [FK_RheemEventCollateral_Collateral]
GO

ALTER TABLE [dbo].[RheemEventCollateral]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventCollateral_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID]) ON DELETE CASCADE
GO

ALTER TABLE [dbo].[RheemEventCollateral] CHECK CONSTRAINT [FK_RheemEventCollateral_RheemEvent]
GO

ALTER TABLE [dbo].[RheemEventCollateral] ADD  CONSTRAINT [DF_RheemEventCollateral_RheemEventCollateralID]  DEFAULT (newid()) FOR [RheemEventCollateralID]
GO

ALTER TABLE [dbo].[RheemEventCollateral] ADD  CONSTRAINT [DF_RheemEventCollateral_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO


