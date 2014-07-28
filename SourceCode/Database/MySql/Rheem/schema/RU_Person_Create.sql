Use rheem;

CREATE TABLE IF NOT EXISTS ru_person(
	PersonID varchar(64) NOT NULL,
	UserID varchar(50) NOT NULL,
	FirstName varchar(50) NOT NULL,
	MiddleName varchar(50) NULL,
	LastName varchar(50) NOT NULL,
	EmailAddress varchar(50) NULL,
	Title varchar(50) NULL,
	Phone varchar(50) NULL,
	Fax varchar(50) NULL,
	MobilePhone varchar(50) NULL,
	ImageID varchar(64) NULL,
	CreatedDate datetime NULL,
	TerminatedDate datetime NULL,
	VaultID varchar(10) NULL,
	Username varchar(50) NULL,
	EncryptedPassword varchar(50) NULL,
	PasswordSeed varchar(50) NULL,
	PasswordDate datetime NULL,
	HubID varchar(100) NULL,
	NealVaultImport datetime NULL,
	VaultPassword varchar(50) NULL,
	Disabled bit NULL,
	Template bit NULL,
	ManagerPersonID varchar(64) NULL,
	PrimaryAddressID varchar(64) NULL,
	PrimaryOrganizationID varchar(64) NULL,
	SignatureDocumentID varchar(64) NULL,
	TreeUpdated datetime NULL,
	WelcomeEmailSent datetime NULL,
	AccountUpdated datetime NULL,
	ByPassDAC bit NULL,
	Gender varchar(1) NULL,
	LastLogin datetime NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (PersonID)
);

call CreateIndexIfNotExists(null, 'person_idx1', 'ru_person', 'UserID', null);
call CreateIndexIfNotExists(null, 'person_idx2', 'ru_person', 'Username', null);
call CreateIndexIfNotExists(null, 'person_idx3', 'ru_person', 'PrimaryAddressID', null);
call CreateIndexIfNotExists(null, 'person_idx4', 'ru_person', 'PrimaryOrganizationID', null);

Call AddColumnIfNotExists(null, 'ru_person', 'mysqlTreeUpdated',  'datetime NULL');
Call AddColumnIfNotExists(null, 'ru_person', 'PartsDistributionWestCoast',  'bit not NULL default 0');
Call AddColumnIfNotExists(null, 'ru_person', 'Signature',  'Text NULL');
