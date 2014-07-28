Use econet;

CREATE TABLE IF NOT EXISTS alertdetail(
	AlertDetailId INT NOT NULL AUTO_INCREMENT ,
	AlertType varchar(50) NOT NULL,
	AlertCode varchar(50) NOT NULL,
	UserMessage varchar(4000) NULL,
	CustomMessage varchar(4000) NULL,
	CallToAction varchar(4000) NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (AlertDetailId)
);


call rheem.AddColumnIfNotExists('econet', 'alertdetail', 'EquipmentMasterId',  'INT NULL AFTER CallToAction');
call rheem.AddColumnIfNotExists('econet', 'alertdetail', 'MsgText',  'VARCHAR(4000) NULL AFTER EquipmentMasterId');
call rheem.AddColumnIfNotExists('econet', 'alertdetail', 'MsgEmail',  'VARCHAR(4000) NULL AFTER MsgText');
call rheem.AddColumnIfNotExists('econet', 'alertdetail', 'MsgPush',  'VARCHAR(500) NULL AFTER MsgEmail');
call rheem.AddColumnIfNotExists('econet', 'alertdetail', 'MsgAppDetail',  'VARCHAR(4000) NULL AFTER MsgPush');

