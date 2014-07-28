USE RheemUsers
-- ------------
-- ModelWarrantyRuleModel 
-- ------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ModelWarrantyRuleCategory') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ModelWarrantyRuleCategory](
	[ModelWarrantyRuleCatagoryID] [uniqueidentifier] NOT NULL,
	[ModelWarrantyRuleID] [uniqueidentifier] NOT NULL,
	[ProductCategoryID] [uniqueidentifier] NOT NULL,
	[CategoryName] [varchar](150) NULL,
	[CreateDateTime__Gen] [datetime] NULL,
	[UpdateDateTime__Gen] [datetime] NULL,
 CONSTRAINT [PK_ModelWarrantyRuleCategory] PRIMARY KEY CLUSTERED 
(
	[ModelWarrantyRuleCatagoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
	
END
GO