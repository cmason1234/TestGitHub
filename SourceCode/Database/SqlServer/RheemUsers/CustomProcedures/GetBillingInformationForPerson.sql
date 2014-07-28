USE [RheemUsers]
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetBillingInformationForPerson') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GetBillingInformationForPerson;
		PRINT 'Dropped GetBillingInformationForPerson'
	END
GO
CREATE PROCEDURE [dbo].[GetBillingInformationForPerson]
(
	@PersonID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
		select org.OrganizationName , org.Phone, do.OracleAccountNumber,  
              do.OracleCustomerSiteNumberACD, do.OracleCustomerSiteNumberRPD , do.OracleCustomerSiteNumberWHD ,  
              a.AddressLine1, a.AddressLine2, a.City, a.State, a.PostalCode, a.AddressType, a.AddressID  
                 from  
              rheemusers..organization org 
			  Inner Join rheemusers..organizationaddress oa on org.OrganizationID = oa.organizationid
              Inner Join rheemusers..address a on oa.addressid = a.AddressID and a.AddressType = 'Billing' 
			  Inner Join rheemusers..DistributorOrganization do on org.OrganizationID = do.organizationid
                 where  
              org.organizationID in 
			    (select po.OrganizationID from rheemusers..PersonOrganization po where po.PersonID=@PersonID ) or  
              org.organizationID in 
			    (  
                 select o.OrganizationID from rheemusers..PersonOrganization po
				      inner join rheemusers ..OrganizationParent op on po.OrganizationID = op.OrganizationID
					  inner join rheemusers..Organization o on  op.ParentOrganizationID = o.OrganizationID and   
                   					  o.OrganizationType ='Distributor'
                    where po.PersonID=@PersonID
				) or  
              org.organizationID in 
			    (  
                 select oO.OrganizationID  from rheemusers..OrganizationParent opO
 				    inner join rheemusers..Organization oO on opO.ParentOrganizationID = oO.OrganizationID and 
					         oO.OrganizationType ='Distributor'  
                    where  
                       opO.OrganizationID in (  
                         select o.OrganizationID from rheemusers..PersonOrganization po
 					        inner join rheemusers ..OrganizationParent op on po.OrganizationID = op.OrganizationID
					        inner join rheemusers..Organization o on op.ParentOrganizationID = o.OrganizationID
                               where po.PersonID=@PersonID )
				)
	
End
GO

