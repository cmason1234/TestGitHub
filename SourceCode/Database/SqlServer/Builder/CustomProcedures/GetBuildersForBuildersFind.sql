USE [Builder]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBuildersForBuildersFind]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBuildersForBuildersFind]
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
CREATE PROCEDURE [dbo].[GetBuildersForBuildersFind]
    -- Add the parameters for the stored procedure here
    @PersonID uniqueidentifier,
    @BuilderName varchar(50),
    @AddressLine1 varchar(50),
    @City varchar(50),
    @State varchar(3),
    @PostalCode varchar(50),
    @Contractor varchar(50),
    @ContractorNumber varchar(50),
    @Distributor varchar(50),
    @DistributorNumber varchar(50),
    @IncludeDisabled bit,
    @Region uniqueidentifier,
    @BRIorDirect varchar(50)

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT * FROM 
    (SELECT DISTINCT o.OrganizationID, b.BuilderID, b.BuilderName, a.AddressLine1, a.City, a.State, a.PostalCode, b.Contact, b.Email, b.Phone, b.Status
    FROM rheemusers..MyOrganizations mo 
        INNER JOIN rheemusers..BuilderOrganization bo ON mo.OrganizationID = bo.OrganizationID 
        INNER JOIN rheemusers..Organization o ON mo.OrganizationID = o.OrganizationID 
        LEFT OUTER JOIN rheemusers..Address a ON o.PrimaryAddressID = a.AddressID 
        INNER JOIN builder..Builder b ON bo.BuilderID = b.BuilderID 
        LEFT OUTER JOIN rheemusers..OrganizationParent region ON region.OrganizationID=o.OrganizationID and region.ParentOrganizationID in (select OrganizationID from rheemusers..Organization where OrganizationType='Region Builder')
    WHERE mo.PersonID = @PersonID and
          (LEN(@BuilderName)=0 OR b.BuilderName like '%' + @BuilderName + '%') and 
          (LEN(@AddressLine1)=0 OR a.AddressLine1 like '%' + @AddressLine1 + '%') and 
          (LEN(@City)=0 OR a.City like '%' + @City + '%') and 
          (LEN(@State)=0 OR a.State = @State) and 
          (LEN(@PostalCode)=0 OR a.PostalCode like '%' + @PostalCode + '%') and 
          (@Region = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) OR region.ParentOrganizationID=@Region) and
          (LEN(@BRIorDirect)=0 OR b.ProgramType = @BRIorDirect) and 
          (LEN(@Distributor)=0 OR b.BuilderID in (SELECT DISTINCT bc.BuilderId  
                                                  FROM rheemusers..DealerOrganization do, Builder..BuilderContractor bc 
                                                  WHERE do.OrganizationID IN ( 
                                                    SELECT OrganizationID 
                                                    FROM rheemusers..ContractorAC 
                                                    WHERE DistributorOrganizationID in (
                                                        SELECT OrganizationID 
                                                        FROM rheemusers..Organization 
                                                        WHERE OrganizationName like  '%' + @Distributor + '%')) and 
                                                              do.DealerID = bc.ContractorID )) and 
          (LEN(@DistributorNumber)=0 OR b.BuilderID in (SELECT DISTINCT bc.BuilderId  
                                                        FROM rheemusers..DealerOrganization do, Builder..BuilderContractor bc 
                                                        WHERE do.OrganizationID IN ( 
                                                            SELECT OrganizationID  
                                                            FROM rheemusers..ContractorAC 
                                                            WHERE DistributorOrganizationID IN (
                                                                SELECT OrganizationID 
                                                                FROM rheemusers..DistributorOrganization 
                                                                WHERE DistributorNumber =@DistributorNumber)) and do.DealerID = bc.ContractorID ))  and
          (LEN(@Contractor)=0 OR b.BuilderID in (SELECT DISTINCT bo.BuilderID
                                                 FROM rheemusers..BuilderOrganization bo 
													INNER JOIN rheemusers..OrganizationParent op ON op.ParentOrganizationID  = bo.OrganizationID         
													INNER JOIN rheemusers..Organization o on op.OrganizationID = o.OrganizationID 
												WHERE o.OrganizationName like '%' + @Contractor + '%')) and
          (LEN(@ContractorNumber)=0 OR b.BuilderID in (SELECT DISTINCT bo.BuilderID
                                                       FROM rheemusers..BuilderOrganization bo 
                                                           INNER JOIN builder..BuilderContractor bc ON bo.BuilderID = bc.BuilderID 
                                                           INNER JOIN rheemdb..Dealer d on bc.ContractorID = d.DealerID 
                                                           INNER JOIN rheemusers..DealerOrganization conO on d.DealerID = conO.DealerID 
                                                           INNER JOIN rheemusers..OrganizationParent op on conO.OrganizationID=op.OrganizationID
                                                           INNER JOIN rheemusers..Organization o on op.OrganizationID = o.OrganizationID 
                                                           INNER JOIN rheemusers..ContractorAC cac ON cac.OrganizationID=o.OrganizationID
                                                       WHERE cac.DealerNumber =@ContractorNumber)) and           
          (@IncludeDisabled = 1 OR b.Status <> 'Disabled')) bigPart
          OUTER APPLY (
            SELECT BrandID, BrandName from RheemDB..Brand b
                INNER JOIN (SELECT COUNT(*) As RheemCount
            FROM RheemUsers..Organization o 
                INNER JOIN RheemUsers..OrganizationParent op on o.OrganizationID = op.ParentOrganizationID
                INNER JOIN RheemUsers..OrganizationBrand ob on o.OrganizationID = ob.OrganizationID 
            WHERE op.OrganizationID = bigPart.OrganizationID and 
                  o.OrganizationType ='Distributor' and ob.BrandID in (
                    SELECT BrandID 
                    FROM RheemDB..Brand where BrandName in ('Rheem','RheemTeam'))) countRows ON 1=1
                    WHERE countRows.RheemCount>0 and BrandName='Rheem'
            ) rheemCount
          OUTER APPLY (
            SELECT BrandID As BrandID2, BrandName as BrandName2 from RheemDB..Brand b
                INNER JOIN (SELECT COUNT(*) As RheemCount
            FROM RheemUsers..Organization o 
                INNER JOIN RheemUsers..OrganizationParent op on o.OrganizationID = op.ParentOrganizationID
                INNER JOIN RheemUsers..OrganizationBrand ob on o.OrganizationID = ob.OrganizationID 
            WHERE op.OrganizationID = bigPart.OrganizationID and 
                  o.OrganizationType ='Distributor' and ob.BrandID in (
                    SELECT BrandID 
                    FROM RheemDB..Brand where BrandName in ('Ruud','Ruud Reliable'))) countRows ON 1=1
                    WHERE countRows.RheemCount>0 and BrandName='Ruud'
            ) ruudCount

    ORDER BY BuilderName

END
GO
