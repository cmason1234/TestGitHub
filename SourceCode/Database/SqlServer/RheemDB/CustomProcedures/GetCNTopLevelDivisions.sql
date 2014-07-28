USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCNTopLevelDivisions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCNTopLevelDivisions]
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
CREATE PROCEDURE [dbo].[GetCNTopLevelDivisions] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
  
select  o.OrganizationName , o.OrganizationID  from RheemUsers ..OrganizationParent op
	left outer join RheemUsers ..Organization o on 
		op.OrganizationID = o.OrganizationID and 
		o.OrganizationType ='Division'  
where
	op.ParentOrganizationID in (
		select oinner.organizationid from RheemUsers ..Organization oinner
			where 
		oinner.OrganizationType='RheemSalesInc' or 
		oinner.OrganizationType='RheemCanadaLTD' 
		) and
	o.OrganizationName is not null
order by o.OrganizationName 
    
END
GO
