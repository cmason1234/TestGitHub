Use ears;

CREATE TABLE IF NOT EXISTS earsalert(
	EarsAlertID INT NOT NULL AUTO_INCREMENT ,
	AlertDateTime datetime NOT NULL,
	AlertMessage varchar(545) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EarsAlertID)		
);

CREATE TABLE IF NOT EXISTS earsemployee(
	EarsEmployeeID INT NOT NULL AUTO_INCREMENT ,
	EmployeeFirstName varchar(45) NOT NULL,
	EmployeeLastName varchar(45) NOT NULL,
	EmployeeCell varchar(45) NULL,
	EmployeeAttribute varchar(45) NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EarsEmployeeID)	
);

CREATE TABLE IF NOT EXISTS earslocation(
	EarsLocationID INT NOT NULL AUTO_INCREMENT ,
	LocationName varchar(45) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EarsLocationID)		
);

CREATE TABLE IF NOT EXISTS earsemployeealert(
	EarsEmployeeAlertID INT NOT NULL AUTO_INCREMENT ,
	EarsEmployeeID INT NOT NULL,
	EarsAlertID INT NOT NULL,
	AlertStatus varchar(245) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (earsEmployeeAlertID),
		CONSTRAINT FK_EmployeeAlert_1 FOREIGN KEY (EarsEmployeeID) REFERENCES earsemployee(EarsEmployeeID) ON DELETE CASCADE,	
		CONSTRAINT FK_EmployeeAlert_2 FOREIGN KEY (EarsAlertID) REFERENCES earsalert(EarsAlertID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS earsemployeelocation(
	EarsEmployeeLocationID INT NOT NULL AUTO_INCREMENT ,
	EarsEmployeeID INT NOT NULL,
	EarsLocationID INT NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (earsEmployeeLocationID),
		CONSTRAINT FK_EmployeeLocation_1 FOREIGN KEY (EarsEmployeeID) REFERENCES earsemployee(EarsEmployeeID) ON DELETE CASCADE,	
		CONSTRAINT FK_EmployeeLocation_2 FOREIGN KEY (EarsLocationID) REFERENCES earslocation(EarsLocationID) ON DELETE CASCADE
);


