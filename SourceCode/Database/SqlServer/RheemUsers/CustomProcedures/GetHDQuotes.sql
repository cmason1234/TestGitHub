USE [rheemusers]
GO

-- This is to drop the now deprecated GetHDQuotesForAdmin
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHDQuotesForAdmin]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetHDQuotesForAdmin]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHDQuotes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetHDQuotes]
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
CREATE PROCEDURE [dbo].[GetHDQuotes] 
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
           a.HDQuoteID,a.PersonID,a.LeadNumber,a.StoreNumber,a.OrganizationID,a.CustomerFirst + ' ' + a.CustomerLast AS CustomerFullName,a.CustomerFirst,a.CustomerLast,a.ProposalDate,a.CustomerEmail,a.CustomerPhoneDay,a.Status,
           d.AddressLine1 + ' ' + d.AddressLine2 + '<br />' + d.City + ', ' + 
           d.State + ' ' + d.PostalCode As CustomerAddress,b.OrganizationName,c.FirstName + ' ' + c.LastName As FullName,c.FirstName,c.LastName
    FROM (select HDQ.*,HDO.IsContractOption from rheemusers..HDQuote HDQ
          LEFT JOIN rheemusers..HDOption HDO ON HDQ.HDQuoteID=HDO.HDQuoteID
          WHERE ProposalDate between @ProposalStartDate and @ProposalEndDate and
          (@IsAdmin=1 OR (HDQ.PersonID = @PersonID) OR HDQ.PersonID in (select HasAccessToPersonID from rheemusers..HDPersonToPersonAccess 
                                          where PersonID=@PersonID))) AS a
    LEFT JOIN rheemusers..Address d ON a.CustomerAddressID=d.AddressID
    LEFT JOIN rheemusers..Organization b ON a.OrganizationID=b.OrganizationID
    LEFT JOIN rheemusers..Person c ON a.PersonID=c.PersonID
    WHERE (LEN(@CustomerFirst)=0 OR a.CustomerFirst like '%' + @CustomerFirst + '%') and
          (LEN(@CustomerLast)=0 OR a.CustomerLast like '%' + @CustomerLast + '%') and
          (LEN(@StoreNumber)=0 OR a.StoreNumber like '%' + @StoreNumber + '%') and 
          (LEN(@LeadNumber)=0 OR a.LeadNumber like '%' + @LeadNumber + '%') and
          (LEN(@InstallProfessional)=0 OR a.InstallProfessional = @InstallProfessional) and 
          (LEN(@CustomerPhone)=0 OR a.CustomerPhoneDay like '%' + @CustomerPhone + '%' or a.CustomerPhoneNight like '%' + @CustomerPhone + '%') and
          (LEN(@CustomerAddress)=0 OR d.AddressLine1 like '%' + @CustomerAddress + '%') and
          (LEN(@CustomerEmail)=0 OR a.CustomerEmail like '%' + @CustomerEmail + '%') and
          (LEN(@CustomerCity)=0 OR d.City like '%' + @CustomerCity + '%') and
          (LEN(@CustomerPostalCode)=0 OR d.PostalCode like '%' + @CustomerPostalCode + '%') and
          (@QuoteOwner = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) OR a.PersonID=@QuoteOwner) and
          (@ContractOrQuote='Both' OR 
              (@ContractOrQuote='Quote' AND (select count(1) from HDOption where IsContractOption>0 and HDQuoteID=a.HDQuoteID)=0) OR
              (@ContractOrQuote='Contract' AND IsContractOption>0)
           )  
    GROUP BY a.HDQuoteID,a.PersonID,a.LeadNumber,a.StoreNumber,b.OrganizationID,a.CustomerFirst,a.CustomerLast,a.CustomerFirst,a.CustomerLast,a.ProposalDate,a.CustomerEmail,a.CustomerPhoneDay,a.Status,
             d.AddressLine1,d.AddressLine2,d.City,d.State,d.PostalCode,b.OrganizationName,c.FirstName,c.LastName,c.FirstName,c.LastName,a.OrganizationID
    ORDER BY a.ProposalDate


END
GO
