USE support;

CREATE TABLE IF NOT EXISTS helpdeskticket (
    HelpDeskTicketNumber INT NOT NULL,
	TicketDate Date NOT NULL,
	LastUpdated Date NOT NULL,
	Status  VARCHAR(50),
	Priority VARCHAR(50),
	AlertLevel VARCHAR(255),
	TechName VARCHAR(255),
	Location VARCHAR(255),
	RequestType VARCHAR(255),
	PRIMARY KEY (HelpDeskTicketNumber),
	INDEX helpdesktickets_idx1 (Status),
	INDEX helpdesktickets_idx2 (Priority),
	INDEX helpdesktickets_idx3 (TicketDate),
	INDEX helpdesktickets_idx4 (LastUpdated),
	INDEX helpdesktickets_idx5 (TechName)
);

Call rheem.AddColumnIfNotExists('support', 'helpdeskticket', 'RequestTypePart1',  'varchar(100)');
Call rheem.AddColumnIfNotExists('support', 'helpdeskticket', 'RequestTypePart2',  'varchar(100)');
Call rheem.AddColumnIfNotExists('support', 'helpdeskticket', 'RequestTypePart3',  'varchar(100)');
