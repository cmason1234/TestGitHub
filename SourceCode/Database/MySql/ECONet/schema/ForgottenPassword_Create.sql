Use econet;

CREATE TABLE IF NOT EXISTS forgottenpassword (
	ForgottenPasswordId INT NOT NULL AUTO_INCREMENT,
	UserId INT NOT NULL,
	PasswordKey varchar(50) NOT NULL,
	UpdateDateTime__Gen datetime NOT NULL,
	CreateDateTime__Gen datetime NOT NULL,
    PRIMARY KEY (ForgottenPasswordId),
	CONSTRAINT FK_ForgottenPassword_1 FOREIGN KEY (UserId) 
			REFERENCES user(UserId) ON DELETE CASCADE
);


call rheem.CreateIndexIfNotExists('econet', 'ForgottenPassword_idx1', 'forgottenpassword', 'UserId', null);
call rheem.CreateIndexIfNotExists('econet', 'ForgottenPassword_idx2', 'forgottenpassword', 'PasswordKey', null);

