USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'LDAPConvert') AND type in (N'U'))
BEGIN


CREATE TABLE LDAPConvert(
	LDAPConvertID uniqueidentifier NOT NULL,
	OldUserName varchar(50) NOT NULL,
	NewUserName varchar(50) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
 CONSTRAINT PK_LDAPConvert PRIMARY KEY CLUSTERED 
(
	LDAPConvertID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
