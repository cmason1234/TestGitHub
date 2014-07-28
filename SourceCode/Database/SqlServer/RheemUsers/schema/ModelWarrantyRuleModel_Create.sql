USE RheemUsers
-- ------------
-- ModelWarrantyRuleModel 
-- ------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ModelWarrantyRuleModel') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ModelWarrantyRuleModel](
	[ModelWarrantyRuleModelID] [uniqueidentifier] NOT NULL,
	[ModelWarrantyRuleID] [uniqueidentifier] NOT NULL,	
	[ProductID] [uniqueidentifier] NOT NULL,
	[Model] [varchar](150) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
 CONSTRAINT [PK_ModelWarrantyRuleModel] PRIMARY KEY CLUSTERED 
(
	[ModelWarrantyRuleModelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
	
END
GO