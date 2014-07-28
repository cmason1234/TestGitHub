USE [RheemEvents]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RheemEventBudget]') AND type in (N'U'))
DROP TABLE [dbo].[RheemEventBudget]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEventBudget](
	[RheemEventBudgetID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[GeneralLedgerCode] [varchar](50) NULL,
	[Description] [varchar](400) NOT NULL,
	[CostInDollars] [float] NOT NULL,
 CONSTRAINT [PK_RheemEventBudget] PRIMARY KEY CLUSTERED 
(
	[RheemEventBudgetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[RheemEventBudget]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventBudget_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID])
ON DELETE CASCADE
GO

