USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHDAgreements]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetHDAgreements]
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
CREATE PROCEDURE [dbo].[GetHDAgreements] 
    -- Add the parameters for the stored procedure here
    @PersonID uniqueidentifier,
    @StoreNumber varchar(50),
    @CustomerLast varchar(50),
    @CustomerFirst varchar(50),
    @InstallProfessional varchar(350),
    @CustomerPhone varchar(50),
    @CustomerAddress varchar(50),
    @CustomerEmail varchar(150),
    @CustomerCity varchar(50),
    @CustomerPostalCode varchar(50),
    @ProposalStartDate datetime,
    @ProposalEndDate datetime,
    @QuoteOwner uniqueidentifier,
    @ContractOrQuote varchar(50),
    @LeadNumber varchar(50),
    @IsAdmin bit = 0

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT SUM(CASE WHEN a.IsContractOption = 1 THEN 1 ELSE 0 END) AS IsContractOption,
           a.HDAgreementID,a.PersonID,a.LeadNumber,a.StoreNumber,a.OrganizationID,a.CustomerFirst + ' ' + a.CustomerLast AS CustomerFullName,a.CustomerFirst,a.CustomerLast,a.ProposalDate,a.CustomerEmail,a.CustomerPhoneDay,a.Status,
           a.Address + '<br />' + a.City + ', ' + 
           a.State + ' ' + a.PostalCode As CustomerAddress,b.OrganizationName,c.FirstName + ' ' + c.LastName As FullName,c.FirstName,c.LastName
    FROM (select HDA.*,HDO.IsContractOption from rheemusers..HDAgreement HDA
          LEFT JOIN rheemusers..HDAgreementOption HDO ON HDA.HDAgreementID=HDO.HDAgreementID
          WHERE ProposalDate between @ProposalStartDate and @ProposalEndDate and
          (@IsAdmin=1 OR (HDA.PersonID = @PersonID) OR HDA.PersonID in (select HasAccessToPersonID from rheemusers..HDPersonToPersonAccess 
                                          where PersonID=@PersonID))) AS a
    LEFT JOIN rheemusers..Organization b ON a.OrganizationID=b.OrganizationID
    LEFT JOIN rheemusers..Person c ON a.PersonID=c.PersonID
    WHERE (LEN(@CustomerFirst)=0 OR a.CustomerFirst like '%' + @CustomerFirst + '%') and
          (LEN(@CustomerLast)=0 OR a.CustomerLast like '%' + @CustomerLast + '%') and
          (LEN(@StoreNumber)=0 OR a.StoreNumber like '%' + @StoreNumber + '%') and 
          (LEN(@LeadNumber)=0 OR a.LeadNumber like '%' + @LeadNumber + '%') and
          (LEN(@InstallProfessional)=0 OR a.InstallationProfessional = @InstallProfessional) and 
          (LEN(@CustomerPhone)=0 OR a.CustomerPhoneDay like '%' + @CustomerPhone + '%' or a.CustomerPhoneEvening like '%' + @CustomerPhone + '%') and
          (LEN(@CustomerAddress)=0 OR a.Address like '%' + @CustomerAddress + '%') and
          (LEN(@CustomerEmail)=0 OR a.CustomerEmail like '%' + @CustomerEmail + '%') and
          (LEN(@CustomerCity)=0 OR a.City like '%' + @CustomerCity + '%') and
          (LEN(@CustomerPostalCode)=0 OR a.PostalCode like '%' + @CustomerPostalCode + '%') and
          (@QuoteOwner = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) OR a.PersonID=@QuoteOwner) and
          (@ContractOrQuote='Both' OR 
              (@ContractOrQuote='Quote' AND (select count(1) from HDAgreementOption where IsContractOption>0 and HDAgreementID=a.HDAgreementID)=0) OR
              (@ContractOrQuote='Contract' AND IsContractOption>0)
           )  
    GROUP BY a.HDAgreementID,a.PersonID,a.LeadNumber,a.StoreNumber,b.OrganizationID,a.CustomerFirst,a.CustomerLast,a.CustomerFirst,a.CustomerLast,a.ProposalDate,a.CustomerEmail,a.CustomerPhoneDay,a.Status,
             a.Address,a.City,a.State,a.PostalCode,b.OrganizationName,c.FirstName,c.LastName,c.FirstName,c.LastName,a.OrganizationID
    ORDER BY a.ProposalDate


END
GO
