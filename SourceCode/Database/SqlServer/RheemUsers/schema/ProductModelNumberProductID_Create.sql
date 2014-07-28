USE RheemUsers

-- ------------
-- ProductModelNumber 
-- ------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductModelNumberProduct') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ProductModelNumberProduct](
	[ProductModelNumberProductID] [uniqueidentifier] NOT NULL,
	[ProductModelNumberID] [uniqueidentifier] NOT NULL,
	[ProductID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ProductModelNumberProductID] PRIMARY KEY CLUSTERED 
(
	[ProductModelNumberProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
	
END
GO

