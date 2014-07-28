USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrganizationsPeople]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetOrganizationsPeople]
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
CREATE PROCEDURE [dbo].[GetOrganizationsPeople]
    -- Add the parameters for the stored procedure here
    @OrgID uniqueidentifier,
    @IncludeDisabledAccounts bit,
    @ExcludeThisPerson uniqueidentifier = NULL
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @IncludeDisabledAccounts=1
    BEGIN
        SELECT p.*, '' AS LastLoginDate, po.PersonOrganizationID, o.OrganizationName, a.*, 
		        p.FirstName + ' ' +  p.LastName Fullname,
                isnull(Disabled, 0) as IsDisabled, 
                convert(varchar,p.LastLogin,101) as LoginDate
        FROM rheemusers..PersonOrganization po 
        INNER JOIN rheemusers..Organization o ON po.OrganizationID = o.OrganizationID  
        INNER JOIN rheemusers..Person p ON po.PersonID = p.PersonID 
        LEFT OUTER JOIN rheemusers..Address a  ON p.PrimaryAddressID = a.AddressID  
        WHERE o.OrganizationID  = @OrgID and 
              p.PersonID <> ISNULL(@ExcludeThisPerson, '00000000-0000-0000-0000-000000000000')
        ORDER BY p.lastname 
    END
    ELSE
    BEGIN
        SELECT p.*, @ExcludeThisPerson As exclude, '' AS LastLoginDate, po.PersonOrganizationID, o.OrganizationName, a.*, 
		       p.FirstName + ' ' +  p.LastName Fullname,
			   isnull(Disabled, 0) as IsDisabled,
               convert(varchar,p.LastLogin,101) as LoginDate
        FROM rheemusers..PersonOrganization po 
        INNER JOIN rheemusers..Organization o ON po.OrganizationID = o.OrganizationID  
        INNER JOIN rheemusers..Person p ON po.PersonID = p.PersonID 
        LEFT OUTER JOIN rheemusers..Address a  ON p.PrimaryAddressID = a.AddressID  
        WHERE o.OrganizationID  = @OrgID and 
              ISNULL(p.Disabled, 0) = 0 and
              p.PersonID <> ISNULL(@ExcludeThisPerson, '00000000-0000-0000-0000-000000000000')
        ORDER BY p.lastname 
    END

END
GO
