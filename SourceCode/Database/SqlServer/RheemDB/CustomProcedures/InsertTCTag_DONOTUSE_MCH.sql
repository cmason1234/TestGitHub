USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertTCTag]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertTCTag]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertTCTag] 
	-- Add the parameters for the stored procedure here
	@OrganizationID uniqueidentifier,
	@TagName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

 
INSERT INTO EC_DistributorTag (EC_DistributorTagID, GDPClaimYear,
OrganizationID, TagName, 
GDPBudget, TCBudget, WHBudget, SPBudget, PROSTOCKBudget) 
   VALUES(
NEWID(), 2013, 
@OrganizationID, 
@TagName,
0,1 ,0 ,0 ,0)
   
END
GO
