Use rheem;

CREATE TABLE IF NOT EXISTS contfindziploc(
		postalcode varchar(100) NOT NULL,
		distance float,
		track varchar(64),
		Primary Key (postalcode),
		INDEX idx1_findziploc (track)
);

Call AddColumnIfNotExists(null, 'contfindziploc', 'CreateDateTime__Gen',  'datetime');

alter table contfindziploc drop primary key, add primary key (postalcode, track);

Create Table if not exists contractorsfind (
	OrganizationID varchar(64),
	OrganizationName varchar(300),
	Phone varchar(50),
	City varchar(50),
	State Varchar(3),
	AddressLine1 varchar(50),
	track varchar(64),
	ACContractor bit, 
	WaterHeaterContractor bit,
	PoolAndSpaContractor bit,
	GeneratorContractor bit,
	KwikComfort bit,
	WebSite varchar(128), 
	postalcode varchar(100) NOT NULL,
	distance float,
	CorporateEmail varchar(50),
	CorporateEmail2 varchar(50),
	GEN bit default 0,
	GENRheem bit default 0,
	GENRuud bit default 0,
	AC bit default 0,
	PS bit  default 0,
	WHCom bit default 0,
	WHRes bit default 0,
	WHTankless bit default 0,
	WHSolar bit default 0,
	ACRheem bit default 0,
	ACRheemTeam bit default 0,
	ACRuud bit default 0,
	ACRuudReliable bit default 0,
	WHRuud bit default 0,
	WHRheem bit default 0,
	WHRichmond bit default 0,
	WHPlace bit default 0,
	ACPlace bit default 0,
	ShowNateLogo bit default 0,
	HomeDepot bit default 0,
	DesignStar bit default 0,
	PPlus bit default 0,
	Cashback bit default 0,
	ASP bit default 0,
	WHInstall bit default 0,
	TopTen bit default 0,
	TopOne bit default 0
);

Call AddColumnIfNotExists(null, 'contractorsfind', 'CreateDateTime__Gen',  'datetime');
call CreateIndexIfNotExists(NULL, 'contractorsfind_idx1', 'contractorsfind', 'track', NULL);

Call AddColumnIfNotExists(null, 'contractorsfind', 'PHCC',  ' bit NULL');
Call AddColumnIfNotExists(null, 'contractorsfind', 'AboutUs',  'varchar(512) NULL');
