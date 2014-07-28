USE RheemUsers

-- ------------
-- ProductModel 
-- ------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductModel') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ProductModel](
	[ProductModelID] [uniqueidentifier] NOT NULL Default newid(),
	[ProductID] [uniqueidentifier] NOT NULL Constraint FK_ProductModel_Product_ProductModelID
		        Foreign Key references Product(ProductID) on delete cascade,
	[RPS_ID] [int] NOT NULL default 0,
	[RPS_Model] [varchar](50) NOT NULL,
	[RPS_Voltage] [int] NOT NULL default 0,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime]  NULL,
 CONSTRAINT [PK_ProductModel] PRIMARY KEY CLUSTERED 
(
	[ProductModelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
	
END
GO

