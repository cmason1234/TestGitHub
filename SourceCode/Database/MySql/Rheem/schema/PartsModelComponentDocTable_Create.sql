Use rheem;

CREATE TABLE IF NOT EXISTS ru_parts_componentdoc(
	Parts_ComponentDocID int NOT NULL AUTO_INCREMENT,
	ComponentNumber varchar(50) NOT NULL,
	URL varchar(2350) NOT NULL,
	isDoc bit NOT NULL,
	Brand varchar(5) NOT NULL,
	HiRes bit NOT NULL,
	PRIMARY KEY (Parts_ComponentDocID),
	INDEX partscomponentdoc_idx1 (ComponentNumber)
);



