IF NOT EXISTS (select * from builder.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='Builder' And COLUMN_NAME='ProposalGenerated') 
	ALTER TABLE Builder..Builder ADD ProposalGenerated datetime NULL
GO