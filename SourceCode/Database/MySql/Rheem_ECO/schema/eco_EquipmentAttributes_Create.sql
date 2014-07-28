USE rheem_eco;

CREATE TABLE IF NOT EXISTS `rheem_eco`.`equipmentattribute` (
  `EquipmentID` INT NULL ,
  `objNumber` INT NULL ,
  `objFlags` VARCHAR(25) NULL ,
  `objLowerLimit` VARCHAR(10) NULL ,
  `objUpperLimit` VARCHAR(10) NULL ,
  `objName` VARCHAR(10) NULL ,
  `objDesc` VARCHAR(25) NULL ,
  `objValue` VARCHAR(100) NULL ,
  PRIMARY KEY (`EquipmentID`,`objNumber`) ,
  INDEX `EquipmentID_UNIQUE` (`EquipmentID` ASC));
  
  ALTER TABLE `rheem_eco`.`equipmentattribute` CHANGE COLUMN `objValue` `objValue` VARCHAR(4000) CHARACTER SET 'utf8' NULL DEFAULT NULL  ;

  
  
  CREATE TABLE IF NOT EXISTS `rheem_eco`.`equipmentattributehistory` (
	`EquipmentAttributeHistoryID` INT NOT NULL AUTO_INCREMENT ,
  `EquipmentID` INT NULL ,
  `objData` BINARY NULL ,  
  `CreateDateTime__Gen` DATETIME NULL ,
  PRIMARY KEY (`EquipmentAttributeHistoryID`) ,
  INDEX `EquipmentID_UNIQUE` (`EquipmentID` ASC));
  
