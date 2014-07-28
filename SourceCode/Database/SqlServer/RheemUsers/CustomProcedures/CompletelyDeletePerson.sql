USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompletelyDeletePerson]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CompletelyDeletePerson]
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
CREATE PROCEDURE [dbo].[CompletelyDeletePerson] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @Err Int
	
	SET NOCOUNT ON
	SET XACT_ABORT ON

	Set @Err = 0
	
	IF @Err = 0  
		BEGIN
			delete from rheemusers..PendingRoleRequest  where PersonID=@PersonID
			if @@Error <> 0 Set @Err = @@Error
		END
	
	IF @Err = 0  
		BEGIN
			delete from rheemusers..Address             where AddressID in (select AddressID from rheemusers..PersonAddress where PersonID=@PersonID)
			if @@Error <> 0 Set @Err = @@Error
		END
	
	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonAddress       where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonBrand         where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonDepartmentJob where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonClipArt       where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonDepartmentJob where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonLog           where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonMailing       where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonNote          where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonOrganization  where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonParent        where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemusers..PersonRole          where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0  
		BEGIN
			delete from rheemdb..CNRequestApprover      where PersonID= @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	IF @Err = 0 
		BEGIN
			delete from rheemusers..Person              where PersonID = @PersonID
			if @@Error <> 0 Set @Err = @@Error
		END

	select @Err
	
END
GO
