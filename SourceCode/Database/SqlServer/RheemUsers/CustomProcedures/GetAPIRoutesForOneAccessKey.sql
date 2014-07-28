USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAPIRoutesForOneAccessKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAPIRoutesForOneAccessKey]
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
CREATE PROCEDURE [dbo].[GetAPIRoutesForOneAccessKey] 
    -- Add the parameters for the stored procedure here
    @accessKeyID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	select am.APIMasterID, APIName, possRoutes.numRoutes, isnull(selRoutes.NumSelected, 0) as NumSelected 
	  from APIMaster am
      INNER JOIN (select APIMasterID, COUNT(*) as numRoutes from APIRoute group by APIMasterID) as possRoutes on am.APIMasterID=possRoutes.APIMasterID
      LEFT OUTER JOIN (
	      Select APIMasterID, COUNT(*) as NumSelected from APIRoute ar 
		    INNER JOIN APIAccessMatrix am on ar.APIRouteID=am.APIRouteID and
               am.APIAccessKeyID=@accessKeyID group by APIMasterID
			   ) as selRoutes on am.APIMasterID=selRoutes.APIMasterID
     order by apiname

    select ar.APIRouteID, ar.APIMasterID, RoutePath, HttpMethod, 
         CASE WHEN am.APIAccessMatrixID IS NULL THEN 'false' ELSE 'true' END As Active 
	  from APIRoute ar
      left outer join APIAccessMatrix am on ar.APIRouteID=am.APIRouteID and
           am.APIAccessKeyID=@accessKeyID
      order by RoutePath

    SELECT ak.AccessKey, o.OrganizationName As KeyOwner
	  FROM rheemusers..APIAccessKey ak
		INNER JOIN rheemusers..Organization o ON o.OrganizationID=ak.KeyOwner
	  WHERE ak.APIAccessKeyID=@accessKeyID
	UNION
	SELECT ak.AccessKey, p.FirstName + ' ' + p.LastName As KeyOwner
  	  FROM rheemusers..APIAccessKey ak
		INNER JOIN rheemusers..Person p ON p.PersonID=ak.KeyOwner
	  WHERE ak.APIAccessKeyID=@accessKeyID
	  ORDER BY KeyOwner

END
GO
