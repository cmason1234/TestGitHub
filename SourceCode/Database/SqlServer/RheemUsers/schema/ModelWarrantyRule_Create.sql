USE RheemUsers

-- ------------
-- ModelWarrantyRule 
-- ------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ModelWarrantyRule') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ModelWarrantyRule](
	[ModelWarrantyRuleID] [uniqueidentifier] NOT NULL,
	[ProductID] [uniqueidentifier] NOT NULL,
	[RuleMessage] [varchar](1500) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
 CONSTRAINT [PK_ModelWarrantyRule] PRIMARY KEY CLUSTERED 
(
	[ModelWarrantyRuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
	
END
GO