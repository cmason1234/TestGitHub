USE [rheemusers]

if NOT EXISTS(select * from sys.columns where Name = N'PayContractor'  
            and Object_ID = Object_ID(N'BuilderOrganization'))
BEGIN			
  ALTER TABLE BuilderOrganization add PayContractor [bit] NULL DEFAULT 0
  
  exec('update BuilderOrganization set PayContractor=0')
END


  