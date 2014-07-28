USE rheem;

DROP PROCEDURE IF Exists WAPI__GEN__PeopleGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__PeopleGet(
    IN apiKey varchar(50),
    IN personIDparam varchar(50))
BEGIN

    SELECT personID,
           UserID,
           FirstName,
           MiddleName,
           LastName,
           EmailAddress,
           Title,
           Phone,
           Fax,
           MobilePhone,
           ImageID,
           CreatedDate,
           TerminatedDate,
           VaultID,
           Username,
           EncryptedPassword,
           PasswordSeed,
           PasswordDate,
           HubID,
           NealVaultImport,
           VaultPassword,
           Disabled,
           Template,
           ManagerPersonID,
           PrimaryAddressID,
           PrimaryOrganizationID,
           SignatureDocumentID,
           TreeUpdated,
           WelcomeEmailSent,
           AccountUpdated,
           ByPassDAC,
           Gender,
           LastLogin,
           CreateDateTime__Gen,
           UpdateDateTime__Gen,
           mysqlTreeUpdated,
           PartsDistributionWestCoast
    FROM rheem.ru_person
    WHERE (LENGTH(personIDparam) = 0 OR personID = personIDparam);

END$$
DELIMITER ;
