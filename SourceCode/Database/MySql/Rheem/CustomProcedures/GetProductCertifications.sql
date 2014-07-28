USE rheem;

DROP PROCEDURE IF Exists GetProductCertifications;

DELIMITER $$
CREATE PROCEDURE GetProductCertifications(
    IN productIDparam varchar(50))
BEGIN
	SELECT c.DisplayName,
           c.ExternalURL,
	       c.Description,
           CONCAT('https://s3.amazonaws.com/AWSProd/CertificationLogos/', cd.CloudFileName) AS ImageURL
	FROM rheem.ru_product p
        INNER JOIN rheem.ru_productcertification pc ON pc.ProductID = p.ProductID
		INNER JOIN rheem.ru_certification c ON c.CertificationID = pc.CertificationID
		LEFT OUTER JOIN rheem.ru_clouddocument cd ON cd.ObjectID = pc.CertificationID and cd.CloudBucket = 'CertificationLogos' and cd.CloudFileName like '%gen_100_100.png'
	WHERE p.ProductID = productIDparam;
END$$
DELIMITER ;