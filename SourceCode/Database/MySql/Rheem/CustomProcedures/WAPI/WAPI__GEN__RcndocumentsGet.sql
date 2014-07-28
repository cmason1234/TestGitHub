USE rheem;

DROP PROCEDURE IF Exists WAPI__GEN__RcndocumentsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__RcndocumentsGet(
    IN apiKey varchar(50),
    IN rcndocumentIDparam varchar(50))
BEGIN

    SELECT DocumentID,
		   DocumentTitle, 
		   DocumentNumber, 
		   Category, 
		   Keywords, 
		   Filename, 
		   MimeTypeOLD, 
		   Hot, 
		   MimeType
    FROM rheem.rcn_document
    WHERE (LENGTH(rcndocumentIDparam) = 0 OR DocumentID = rcndocumentIDparam);

END$$
DELIMITER ;
