Use rheem;

CREATE TABLE IF NOT EXISTS ru_htmltemplates(
	HTMLTemplateID varchar(64) NOT NULL,
	TemplateName varchar(50) NULL,
	Template text NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (HTMLTemplateID)
);


