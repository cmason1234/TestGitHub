Use econet;

CREATE TABLE IF NOT EXISTS user(
	UserId INT NOT NULL AUTO_INCREMENT ,
	FirstName varchar(50) NOT NULL,
	MiddleName varchar(50) NULL,
	LastName varchar(50) NOT NULL,
	EmailAddress varchar(50) not NULL,
	Title varchar(50) NULL,
	Phone varchar(50) NULL,
	Fax varchar(50) NULL,
	MobilePhone varchar(50) NULL,
	Disabled bit NOT NULL default 0,
	EncryptedPassword varchar(50) not NULL,
	PasswordSeed varchar(50) not NULL,
	PasswordDate datetime not NULL,
	PrimaryUserLocationId int NULL,
    TemperatureDisplayMode varchar(1) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (UserId)
);

call rheem.CreateIndexIfNotExists('econet', 'User_idx1', 'user', 'UserId', null);
call rheem.CreateIndexIfNotExists('econet', 'User_idx2', 'user', 'LastName', null);

INSERT IGNORE INTO user SET UserId=1, FirstName='Matthew', LastName='Carroll', EmailAddress='matthew.carroll@stablekernel.com', Title='Mr.', Phone='xxx', Fax='fax number', MobilePhone='xxx', Disabled=0, EncryptedPassword='2B5432455D5445595045415E5034595540435C57462F504532', PasswordSeed='d6af88d7-36b8-471d-9a98-446fc790c7f1', PasswordDate='2013-11-12 18:17:03', TemperatureDisplayMode='F', CreateDateTime__Gen='2013-11-12 18:17:03', 	UpdateDateTime__Gen='2013-11-12 18:17:03';
INSERT IGNORE INTO user SET UserId=2, FirstName='Jesse', LastName='Black', EmailAddress='jesse.black@stablekernel.com', Title='Mr.', Phone='xxx', Fax='fax number', MobilePhone='xxx', Disabled=0, EncryptedPassword='5F2046425129514342272C544B47515E544744512E504B4223', PasswordSeed='5884b63c-534a-47b8-8f10-7ad06b3519aa', PasswordDate='2013-11-12 18:17:03', TemperatureDisplayMode='F', CreateDateTime__Gen='2013-11-12 18:17:03', 	UpdateDateTime__Gen='2013-11-12 18:17:03';
INSERT IGNORE INTO user SET UserId=3, FirstName='Bill', LastName='Hainaut', EmailAddress='billhainaut@gmail.com', Title='Mr.', Phone='xxx', Fax='fax number', MobilePhone='xxx', Disabled=0, EncryptedPassword='5F2046425129514342272C544B47515E544744512E504B4223', PasswordSeed='5884b63c-534a-47b8-8f10-7ad06b3519aa', PasswordDate='2013-11-12 18:17:03', TemperatureDisplayMode='F', CreateDateTime__Gen='2013-11-12 18:17:03', 	UpdateDateTime__Gen='2013-11-12 18:17:03';


