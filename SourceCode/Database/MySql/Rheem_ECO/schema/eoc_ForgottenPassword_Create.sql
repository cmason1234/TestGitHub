USE rheem_eco;

CREATE TABLE IF NOT EXISTS `rheem_eco`.`forgottenpassword` (
  `ForgottenPasswordID` INT NOT NULL ,
  `HomeOwnerID` INT NOT NULL ,
  `PasswordKey` VARCHAR(50) NULL ,
  PRIMARY KEY (`ForgottenPasswordID`) ,
  UNIQUE INDEX `ForgottenPasswordID_UNIQUE` (`ForgottenPasswordID` ASC) );
  
  Call rheem.CreateForeignKeyIfNotExists ('rheem_eco', 'FK_ForgottenPassword_1', 'forgottenpassword', 'HomeOwnerID', 
                       'homeowner', 'HomeOwnerID', 'leaveUnchanged', NULL ) ;
  call rheem.CreateIndexIfNotExists('rheem_eco', 'FK_ForgottenPassword_1_idx', 'forgottenpassword', 'HomeOwnerID', NULL);

  ALTER TABLE `rheem_eco`.`forgottenpassword` CHANGE COLUMN `ForgottenPasswordID` `ForgottenPasswordID` INT(11) NOT NULL AUTO_INCREMENT  ;
