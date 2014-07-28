IF NOT EXISTS (select * from builder.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='BuilderRebate' And COLUMN_NAME='WHTank60') 
	ALTER TABLE Builder..BuilderRebate ADD WHTank60 float NULL
GO

IF NOT EXISTS (select * from builder.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='BuilderRebate' And COLUMN_NAME='WHTanklessHiEff95') 
	ALTER TABLE Builder..BuilderRebate ADD WHTanklessHiEff95 float not NULL default 0
GO

IF NOT EXISTS (select * from builder.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='BuilderRebate' And COLUMN_NAME='WHTanklessHiEff84') 
	ALTER TABLE Builder..BuilderRebate ADD WHTanklessHiEff84 float not NULL default 0
GO