USE [RheemDB]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'AllocatedClaims') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[AllocatedClaims](
		[AllocatedClaimsID] [uniqueIdentifier] NOT NULL,
		[ClaimYear] [integer] Not Null,
		[OrganizationID] [uniqueidentifier] Not Null,
		[Month] varchar(3) Not Null,
		[ClaimID] uniqueIdentifier Not Null,
	 CONSTRAINT [PK_AllocatedClaims] PRIMARY KEY CLUSTERED 
	(
		[AllocatedClaimsID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY] 

    Alter Table AllocatedClaims Add Constraint FK_AllocatedClaim_ECClaims Foreign Key
        (ClaimID) REFERENCES EC_Claims(ClaimID) on delete cascade
END
GO
