USE RheemUsers
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.KwikComfortAnalyzer') AND type in (N'U'))
BEGIN
	CREATE TABLE dbo.KwikComfortAnalyzer( 
		KwikComfortAnalyzerID uniqueidentifier NOT NULL, 
		MerchantNumber Varchar(150) NULL, 
		MerchantName Varchar(150) NULL, 
		ClientSpecific Varchar(150) NULL, 
		Address Varchar(150) NULL, 
		City Varchar(150) NULL, 
		State Varchar(150) NULL, 
		Zip Varchar(50) NULL,
		Phone Varchar(30) NULL
	CONSTRAINT PK_KwikComfortAnalyzer PRIMARY KEY CLUSTERED 
	( 
		KwikComfortAnalyzerID ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY] 

END

