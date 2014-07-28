Use rheem;

CREATE TABLE IF NOT EXISTS forgottenpassword(
		ForgottenPasswordID varchar(64) NOT NULL,
		PersonID varchar(64) NOT NULL,
		CreateDateTime__Gen datetime NOT NULL,
		Primary Key (ForgottenPasswordID),
		INDEX idx1_forpass (PersonID)
);
