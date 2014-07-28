USE [RheemUsers]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AdMakerImage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AdMakerImage](
    [AdMakerImageID] [uniqueidentifier] NOT NULL,
    [BrandID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
    [ImageType] [varchar](50) NOT NULL,
    [ImageUrl] [varchar](250) NOT NULL,
    [PageSize] [varchar](50) NOT NULL,
    [AssetCategory] [varchar](50) NOT NULL,
	[BlackWhite] [bit] NOT NULL DEFAULT 0,
	[Disabled] [bit] NOT NULL DEFAULT 0,
    [CreateDateTime__Gen] [datetime] NULL,
    [UpdateDateTime__Gen] [datetime] NULL,
 CONSTRAINT [PK_AdMakerImage] PRIMARY KEY CLUSTERED 
(
    [AdmakerImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO

if NOT EXISTS(select * from sys.columns where Name = N'HorizVert'  
            and Object_ID = Object_ID(N'AdMakerImage'))
BEGIN
    ALTER TABLE AdMakerImage add HorizVert varchar(1) not NULL default 'X' 
    exec('ALTER TABLE AdMakerImage ADD constraint DF_AdMakerIM_HorizVert CHECK  ((HorizVert=''X'' OR HorizVert=''V'' OR HorizVert=''H''))')
    exec('Update AdMakerImage set HorizVert=''X''')
    exec('Update AdMakerImage set HorizVert=''H'' where AssetCategory like ''%Horizontal%''')
    exec('Update AdMakerImage set HorizVert=''V'' where AssetCategory like ''%Vertical%''')
END
GO

