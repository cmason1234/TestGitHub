/*
  This tool sql was developed to obtain a list of words
  Typed into the OtherDescription Field for Other Categories.
  change the year to get the values for different years.
*/

SELECT SectionName, 
            CASE OtherRequired
            When Null Then CategoryName
            When 0 Then CategoryName
            When 1 Then OtherDescription
            END as CatName,
           o.OrganizationName
        FROM rheemdb..EC_ClaimSectionCategory csc, 
        rheemdb..EC_ClaimSection cs, 
        rheemdb..EC_ClaimBudget cb,
        RheemUsers..Organization o
        WHERE csc.ClaimSectionID = cs.ClaimSectionId and
        (csc.nonbilling is null or csc.NonBilling =0) and 
        cs.GDPSection=1 and csc.CategoryName not in ( 'Credit' ) and 
       cb.ClaimsectionCategoryId =csc.ClaimsectionCategoryId and 
       not(csc.OtherRequired = 1 and (cb.OtherDescription is null or cb.OtherDescription='')) and 
       cb.BudgetYear = 2012 and
       cb.OrganizationID = o.OrganizationID
       ORDER BY SectionName, CatName, OrganizationName
	   
	   