USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorsWithLocatorAgreementStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorsWithLocatorAgreementStatus]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetContractorsWithLocatorAgreementStatus] 
    -- Add the parameters for the stored procedure here
    @OrgID uniqueidentifier,
    @contractorState varchar(50) 
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @contractorState = 'UNDER_CONTRACT'
    BEGIN
        SELECT DISTINCT innerO.OrganizationID,
               innerO.OrganizationName
        FROM rheemusers..OrganizationParent op
            INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=op.OrganizationID
			INNER JOIN rheemusers..ContractorAC innerCAC ON 
				innerCAC.OrganizationID=innerO.OrganizationID and 
				(innerCAC.disabled is null or innerCAC.Disabled=0)
            INNER JOIN rheemusers..ContractorLocatorAgreement cla ON cla.OrganizationID=innerO.OrganizationID and
                                cla.OrganizationID=innerO.OrganizationID AND cla.Historical=0 and cla.ApprovedDate IS NOT NULL
        WHERE @OrgID IS NULL OR (op.ParentOrganizationID=@OrgID
              and innerO.OrganizationType in ('Dealer', 'Contractor'))
    END

    IF @contractorState = 'DENIED'
    BEGIN
        SELECT DISTINCT innerO.OrganizationID,
               innerO.OrganizationName
        FROM rheemusers..OrganizationParent op
            INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=op.OrganizationID
			INNER JOIN rheemusers..ContractorAC innerCAC ON 
				innerCAC.OrganizationID=innerO.OrganizationID and 
				(innerCAC.disabled is null or innerCAC.Disabled=0)
            INNER JOIN rheemusers..ContractorLocatorAgreement cla ON cla.OrganizationID=innerO.OrganizationID and
                                cla.OrganizationID=innerO.OrganizationID AND cla.Historical=0 and cla.DeniedDate IS NOT NULL
        WHERE @OrgID IS NULL OR (op.ParentOrganizationID=@OrgID)
            and innerO.OrganizationType in ('Dealer', 'Contractor')
    END

    IF @contractorState = 'PENDING'
    BEGIN
        SELECT DISTINCT innerO.OrganizationID,
               innerO.OrganizationName
        FROM rheemusers..OrganizationParent op
            INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=op.OrganizationID
			INNER JOIN rheemusers..ContractorAC innerCAC ON 
				innerCAC.OrganizationID=innerO.OrganizationID and 
				(innerCAC.disabled is null or innerCAC.Disabled=0)
            INNER JOIN rheemusers..ContractorLocatorAgreement cla ON cla.OrganizationID=innerO.OrganizationID and
                                cla.OrganizationID=innerO.OrganizationID AND cla.Historical=0 and cla.ApprovedDate IS NULL and cla.DeniedDate IS NULL
        WHERE @OrgID IS NULL OR (op.ParentOrganizationID=@OrgID
            and innerO.OrganizationType in ('Dealer', 'Contractor'))
    END

    IF @contractorState = 'TO_BE_REMOVED' AND @OrgID IS NULL
    BEGIN
        SELECT DISTINCT innerO.OrganizationID,
               innerO.OrganizationName
        FROM rheemusers..OrganizationParent op
            INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=op.OrganizationID
			INNER JOIN rheemusers..ContractorAC innerCAC ON 
				innerCAC.OrganizationID=innerO.OrganizationID and 
				(innerCAC.disabled is null or innerCAC.Disabled=0)
        WHERE (op.ParentOrganizationID IN (SELECT DISTINCT OrganizationID from rheemusers..DistributorLocatorProcess))
            and innerO.OrganizationType in ('Dealer', 'Contractor')
            and innerO.OrganizationID NOT IN (SELECT OrganizationID FROM rheemusers..ContractorLocatorAgreement 
                                              WHERE Historical=0 AND ApprovedDate IS NOT NULL)
    END

    IF @contractorState = 'TO_BE_REMOVED' AND @OrgID IS NOT NULL
    BEGIN
        SELECT DISTINCT innerO.OrganizationID,
               innerO.OrganizationName
        FROM rheemusers..OrganizationParent op
            INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=op.OrganizationID
			INNER JOIN rheemusers..ContractorAC innerCAC ON 
				innerCAC.OrganizationID=innerO.OrganizationID and 
				(innerCAC.disabled is null or innerCAC.Disabled=0)

        WHERE op.ParentOrganizationID=@OrgID and
              innerO.OrganizationType in ('Dealer', 'Contractor') and
              innerO.OrganizationID NOT IN (SELECT DISTINCT innerO.OrganizationID
                                    FROM rheemusers..OrganizationParent op
                                        INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=op.OrganizationID
                                        INNER JOIN rheemusers..ContractorLocatorAgreement cla ON cla.OrganizationID=innerO.OrganizationID and
                                                            cla.OrganizationID=innerO.OrganizationID AND cla.Historical=0 and cla.ApprovedDate IS NOT NULL
                                    WHERE op.ParentOrganizationID=@OrgID
                                        and innerO.OrganizationType in ('Dealer', 'Contractor')) 
    END


END
GO
