Use econet;

CREATE TABLE IF NOT EXISTS contractorinfo(
	ContractorInfoId INT NOT NULL AUTO_INCREMENT ,
	UserId INT NULL,
	CompanyName varchar(150) NOT NULL,
	ContactName varchar(150) NULL,
	Phone varchar(50) NULL,
	Email varchar(200) NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (ContractorInfoId),
		CONSTRAINT FK_ContractorInfo_1 FOREIGN KEY (UserId) REFERENCES user(UserId) ON DELETE NO ACTION 
);

call rheem.CreateIndexIfNotExists('econet', 'ContractorInfo_idx1', 'contractorinfo', 'UserId', null);

CREATE TABLE IF NOT EXISTS systemexpertise(
	SystemExpertiseId INT NOT NULL AUTO_INCREMENT ,
	SystemExpertiseName varchar(50) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (SystemExpertiseId)
);

CREATE TABLE IF NOT EXISTS contractorsystemexpertise(
	ContractorSystemExpertiseId INT NOT NULL AUTO_INCREMENT ,
	ContractorInfoId INT NOT NULL,
	SystemExpertiseId INT NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (ContractorSystemExpertiseId),
		CONSTRAINT FK_ContractorSystemExpertise_1 FOREIGN KEY (ContractorInfoId) REFERENCES contractorinfo(ContractorInfoId) ON DELETE CASCADE,
		CONSTRAINT FK_ContractorSystemExpertise_2 FOREIGN KEY (SystemExpertiseId) REFERENCES systemexpertise(SystemExpertiseId) ON DELETE CASCADE 
);

INSERT IGNORE INTO systemexpertise SET SystemExpertiseId = 1, SystemExpertiseName = 'HVAC', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO systemexpertise SET SystemExpertiseId = 2, SystemExpertiseName = 'Water Heater', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO systemexpertise SET SystemExpertiseId = 3, SystemExpertiseName = 'Pool and Spa', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();

