USE support;

CREATE TABLE IF NOT EXISTS glossary(
    GlossaryId int(11) NOT NULL AUTO_INCREMENT,
	AlphaCharacter varchar(1) NOT NULL,
	Term varchar(256) NOT NULL,
	TermDefinition varchar(4000) NOT NULL,
	CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (GlossaryId)
);

CREATE TABLE IF NOT EXISTS glossarywebsite(
    GlossaryWebsiteId int(11) NOT NULL AUTO_INCREMENT,
	GlossaryId int NOT NULL,
	RheemWebSiteID varchar(64) NOT NULL,
	PRIMARY KEY (GlossaryWebsiteId)
);

CREATE TABLE IF NOT EXISTS glossarydivision(
    GlossaryDivisionId int(11) NOT NULL AUTO_INCREMENT,
	GlossaryId int NOT NULL,
	OrganizationID varchar(64) NOT NULL,
	PRIMARY KEY (GlossaryDivisionId)
);

call rheem.CreateForeignKeyIfNotExists('support', 'GlossaryWebSiteFK1', 'glossarywebsite', 'GlossaryId', 'glossary', 'GlossaryId', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('support', 'GlossaryDivisionFK1', 'glossarydivision', 'GlossaryId', 'glossary', 'GlossaryId', 'dropAndReplace', 'ON DELETE CASCADE');		


