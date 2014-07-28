USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MenuApplicationRole]') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[MenuApplicationRole](
	[MenuApplicationRoleID] [uniqueidentifier] NOT NULL,
	[MenuID] [uniqueidentifier] NULL,
	[ApplicationRoleID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_MenuApplicationRole] PRIMARY KEY CLUSTERED 
(
	[MenuApplicationRoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

END
GO


