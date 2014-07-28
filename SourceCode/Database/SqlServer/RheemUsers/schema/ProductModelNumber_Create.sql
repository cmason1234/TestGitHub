USE RheemUsers

-- ------------
-- ProductModelNumber 
-- ------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductModelNumber') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ProductModelNumber](
	[ProductModelNumberID] [uniqueidentifier] NOT NULL,
	[ManufacturingModelNumber] [varchar](50) NOT NULL,
	[MarketingModelNumber] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ProductModelNumber] PRIMARY KEY CLUSTERED 
(
	[ProductModelNumberID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
	
END
GO

