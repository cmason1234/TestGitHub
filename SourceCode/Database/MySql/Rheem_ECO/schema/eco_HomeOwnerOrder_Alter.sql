USE rheem_eco;

Call rheem.DropForeignKeyIfExists('rheem_eco', 'homeownerorder', 'FK_HomeOwnerOrder_2');

-- Add the column if it doesn't exist, if it does exist, then alter it to the proper datatype
Call rheem.AddColumnIfNotExists('rheem_eco', 'homeownerorder', 'EquipmentID',  'int NOT NULL Default 0');
ALTER TABLE `rheem_eco`.`homeownerorder` CHANGE COLUMN `EquipmentID` `EquipmentID` INT(11) NOT NULL Default 0;

Call rheem.CreateForeignKeyIfNotExists ('rheem_eco', 'FK_HomeOwnerOrder_2', 'homeownerorder', 'EquipmentID', 
                       'equipment', 'EquipmentID', 'leaveUnchanged', NULL ) ;
