USE rheem;

DROP PROCEDURE IF Exists WAPI__ProductCertifications__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ProductCertifications__Get(
    IN apiKey varchar(50),
    IN productIDparam varchar(50))
BEGIN
	SELECT c.DisplayName,
           c.ExternalURL,
	       c.Description,
           CONCAT('https://s3.amazonaws.com/AWSProd/CertificationLogos/', cd.CloudFileName) AS ImageURL
	FROM rheem.ru_apiaccesskey apik
		INNER JOIN rheem.ru_organizationbrand ob ON ob.OrganizationID = apik.KeyOwner
		INNER JOIN rheem.ru_product p ON p.BrandID = ob.BrandID
        INNER JOIN rheem.ru_productcertification pc ON pc.ProductID = p.ProductID
		INNER JOIN rheem.ru_certification c ON c.CertificationID = pc.CertificationID
		LEFT OUTER JOIN rheem.ru_clouddocument cd ON cd.ObjectID = pc.CertificationID and cd.CloudBucket = 'CertificationLogos' and cd.CloudFileName like '%gen_100_100.png'
	WHERE p.ProductID = productIDparam and
          apik.accesskey = apiKey;
END$$
DELIMITER ;
