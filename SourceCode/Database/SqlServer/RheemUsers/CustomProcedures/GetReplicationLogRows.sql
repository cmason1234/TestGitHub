USE [RheemUsers]
GO
/****** Object:  StoredProcedure [dbo].[GetApplicationRoleCountForPerson]    Script Date: 11/17/2010 13:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetApplicationRoleCountForPerson
   
   Description:  If user has access to Application it gets a count ''
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 8:13:49 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetReplicationLogRows') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GetReplicationLogRows;
	END
GO
CREATE PROCEDURE [dbo].[GetReplicationLogRows]
   @NumRows int
	-- params here

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

	SELECT TOP (@NumRows) TableName, DbName, PKID, TypeName, ReplicationLogID
	FROM rheemusers..ReplicationLog 
	ORDER BY ReplicationLogNumber ASC

End
GO
