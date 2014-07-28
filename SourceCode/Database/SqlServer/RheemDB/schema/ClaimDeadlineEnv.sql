Use [RheemDB]
GO

if NOT EXISTS(SELECT * FROM sysindexes where name='uix_EnvName')
    Create Unique Index uix_EnvName on Env(EnvName)
	
if NOT EXISTS(Select * from Env where EnvName='EClaimsDeadLineDays')
    Insert into Env(EnvID, EnvName, EnvValue) values (newid(), 'EClaimsDeadLineDays', '23')
