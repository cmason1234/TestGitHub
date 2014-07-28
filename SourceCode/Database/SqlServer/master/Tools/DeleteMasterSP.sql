/*
       This file will remove many junk Stored procedures and function put into the Master
	   Database on accident over the years.  It may be run more than once.
*/

USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[CountDays]    Script Date: 02/01/2012 09:58:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountDays]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CountDays]
GO

USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[CountDaysByMonths]    Script Date: 02/01/2012 09:59:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountDaysByMonths]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CountDaysByMonths]
GO

USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[CountDaysByWeeks]    Script Date: 02/01/2012 09:59:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountDaysByWeeks]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[CountDaysByWeeks]
GO



USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteCNTemplate]    Script Date: 01/31/2012 07:22:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteCNTemplate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteCNTemplate]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteContactCategories]    Script Date: 01/31/2012 07:23:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteContactCategories]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteContactCategories]
GO



USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteContactEmails]    Script Date: 01/31/2012 07:22:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteContactEmails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteContactEmails]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteContactEmails]    Script Date: 01/31/2012 07:23:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteContactEmails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteContactEmails]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteContactFAQs]    Script Date: 01/31/2012 07:23:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteContactFAQs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteContactFAQs]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteContactLists]    Script Date: 01/31/2012 07:24:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteContactLists]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteContactLists]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteEnv]    Script Date: 01/31/2012 07:24:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteEnv]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteEnv]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 01/31/2012 07:25:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteProduct]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteProductCategoryDocument]    Script Date: 01/31/2012 07:25:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProductCategoryDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteProductCategoryDocument]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteProductDocument]    Script Date: 01/31/2012 07:25:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProductDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteProductDocument]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteProductLog]    Script Date: 01/31/2012 07:25:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProductLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteProductLog]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteProductNotes]    Script Date: 01/31/2012 07:26:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProductNotes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteProductNotes]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteProductProductGroup]    Script Date: 01/31/2012 07:26:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProductProductGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteProductProductGroup]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteracingGuests2011]    Script Date: 01/31/2012 07:26:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteracingGuests2011]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteracingGuests2011]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteRheemTeamServiceRequest]    Script Date: 01/31/2012 07:26:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteRheemTeamServiceRequest]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteRheemTeamServiceRequest]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteSEER]    Script Date: 01/31/2012 07:26:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteSEER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteSEER]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteSeries]    Script Date: 01/31/2012 07:26:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteSeries]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteSeries]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[DeleteSeriesDocument]    Script Date: 01/31/2012 07:27:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteSeriesDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteSeriesDocument]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Deletetraining_class_registrations]    Script Date: 01/31/2012 07:27:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Deletetraining_class_registrations]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Deletetraining_class_registrations]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Deletetraining_classes]    Script Date: 01/31/2012 07:27:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Deletetraining_classes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Deletetraining_classes]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetClassContacts]    Script Date: 01/31/2012 07:27:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClassContacts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClassContacts]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetClassInstructors]    Script Date: 01/31/2012 07:27:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClassInstructors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClassInstructors]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetClassReport]    Script Date: 01/31/2012 07:27:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClassReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClassReport]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetClassSchedulers]    Script Date: 01/31/2012 07:27:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClassSchedulers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClassSchedulers]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetClassSponsors]    Script Date: 01/31/2012 07:36:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClassSponsors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClassSponsors]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetClassTypes]    Script Date: 01/31/2012 07:36:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClassTypes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClassTypes]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetCNTemplateByID]    Script Date: 01/31/2012 07:36:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCNTemplateByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCNTemplateByID]
GO

USE [master]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetContactCategoriesByID]    Script Date: 02/01/2012 11:52:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContactCategoriesByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContactCategoriesByID]
GO


/****** Object:  StoredProcedure [dbo].[GetContactEmailsByID]    Script Date: 01/31/2012 07:36:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContactEmailsByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContactEmailsByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetContactFAQsByID]    Script Date: 01/31/2012 07:36:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContactFAQsByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContactFAQsByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetContactListsByID]    Script Date: 01/31/2012 07:37:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContactListsByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContactListsByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetEnvByID]    Script Date: 01/31/2012 07:37:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEnvByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetEnvByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetProductByID]    Script Date: 01/31/2012 07:37:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductByID]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetProductCategoryDocumentByID]    Script Date: 01/31/2012 07:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductCategoryDocumentByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductCategoryDocumentByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetProductDocumentByID]    Script Date: 01/31/2012 07:38:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductDocumentByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductDocumentByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetProductLogByID]    Script Date: 01/31/2012 07:38:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductLogByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductLogByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetProductNotesByID]    Script Date: 01/31/2012 07:38:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductNotesByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductNotesByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetProductProductGroupByID]    Script Date: 01/31/2012 07:38:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductProductGroupByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductProductGroupByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetracingGuests2011ByID]    Script Date: 01/31/2012 07:38:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetracingGuests2011ByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetracingGuests2011ByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetRheemTeamServiceRequestByID]    Script Date: 01/31/2012 07:38:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRheemTeamServiceRequestByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRheemTeamServiceRequestByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetSEERByID]    Script Date: 01/31/2012 07:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSEERByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSEERByID]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetSeriesByID]    Script Date: 01/31/2012 07:38:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSeriesByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSeriesByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[GetSeriesDocumentByID]    Script Date: 01/31/2012 07:39:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSeriesDocumentByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSeriesDocumentByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Gettraining_class_registrationsByID]    Script Date: 01/31/2012 07:39:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Gettraining_class_registrationsByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Gettraining_class_registrationsByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Gettraining_classesByID]    Script Date: 01/31/2012 07:39:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Gettraining_classesByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Gettraining_classesByID]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertCNTemplate]    Script Date: 01/31/2012 07:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertCNTemplate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertCNTemplate]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertContactCategories]    Script Date: 01/31/2012 07:39:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertContactCategories]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertContactCategories]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertContactEmails]    Script Date: 01/31/2012 07:39:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertContactEmails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertContactEmails]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertContactFAQs]    Script Date: 01/31/2012 07:40:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertContactFAQs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertContactFAQs]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertContactLists]    Script Date: 01/31/2012 07:40:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertContactLists]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertContactLists]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertEnv]    Script Date: 01/31/2012 07:40:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEnv]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertEnv]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 01/31/2012 07:40:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertProduct]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertProductCategoryDocument]    Script Date: 01/31/2012 07:40:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProductCategoryDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertProductCategoryDocument]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertProductDocument]    Script Date: 01/31/2012 07:40:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProductDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertProductDocument]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertProductLog]    Script Date: 01/31/2012 07:40:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProductLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertProductLog]
GO


USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertProductNotes]    Script Date: 01/31/2012 07:41:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProductNotes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertProductNotes]
GO


USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertProductProductGroup]    Script Date: 01/31/2012 07:41:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProductProductGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertProductProductGroup]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertracingGuests2011]    Script Date: 01/31/2012 07:41:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertracingGuests2011]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertracingGuests2011]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertRheemTeamServiceRequest]    Script Date: 01/31/2012 07:41:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertRheemTeamServiceRequest]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertRheemTeamServiceRequest]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertSEER]    Script Date: 01/31/2012 07:41:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertSEER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertSEER]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertSeries]    Script Date: 01/31/2012 07:43:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertSeries]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertSeries]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[InsertSeriesDocument]    Script Date: 01/31/2012 07:43:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertSeriesDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InsertSeriesDocument]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Inserttraining_class_registrations]    Script Date: 01/31/2012 07:43:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inserttraining_class_registrations]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Inserttraining_class_registrations]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Inserttraining_classes]    Script Date: 01/31/2012 07:43:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inserttraining_classes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Inserttraining_classes]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[ReportGetWebContacts]    Script Date: 01/31/2012 07:44:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportGetWebContacts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ReportGetWebContacts]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchCNTemplateByString]    Script Date: 01/31/2012 07:44:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchCNTemplateByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchCNTemplateByString]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchContactCategoriesByString]    Script Date: 01/31/2012 07:45:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchContactCategoriesByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchContactCategoriesByString]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchContactEmailsByString]    Script Date: 01/31/2012 07:45:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchContactEmailsByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchContactEmailsByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchContactFAQsByString]    Script Date: 01/31/2012 07:45:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchContactFAQsByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchContactFAQsByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchContactListsByString]    Script Date: 01/31/2012 07:45:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchContactListsByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchContactListsByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchContactListsByStringForSubTopic]    Script Date: 01/31/2012 07:45:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchContactListsByStringForSubTopic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchContactListsByStringForSubTopic]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchEnvByString]    Script Date: 01/31/2012 07:45:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchEnvByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchEnvByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchProductByString]    Script Date: 01/31/2012 07:45:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchProductByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchProductByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchProductCategoryDocumentByString]    Script Date: 01/31/2012 07:45:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchProductCategoryDocumentByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchProductCategoryDocumentByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchProductDocumentByString]    Script Date: 01/31/2012 07:46:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchProductDocumentByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchProductDocumentByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchProductLogByString]    Script Date: 01/31/2012 07:46:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchProductLogByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchProductLogByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchProductNotesByString]    Script Date: 01/31/2012 07:46:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchProductNotesByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchProductNotesByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchProductProductGroupByString]    Script Date: 01/31/2012 07:46:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchProductProductGroupByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchProductProductGroupByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchracingGuests2011ByString]    Script Date: 01/31/2012 07:46:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchracingGuests2011ByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchracingGuests2011ByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchRheemTeamServiceRequestByString]    Script Date: 01/31/2012 07:46:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchRheemTeamServiceRequestByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchRheemTeamServiceRequestByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchSEERByString]    Script Date: 01/31/2012 07:46:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchSEERByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchSEERByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchSeriesByString]    Script Date: 01/31/2012 07:46:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchSeriesByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchSeriesByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[SearchSeriesDocumentByString]    Script Date: 01/31/2012 07:46:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchSeriesDocumentByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchSeriesDocumentByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Searchtraining_class_registrationsByString]    Script Date: 01/31/2012 07:47:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Searchtraining_class_registrationsByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Searchtraining_class_registrationsByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Searchtraining_classesByString]    Script Date: 01/31/2012 07:47:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Searchtraining_classesByString]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Searchtraining_classesByString]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateCNTemplate]    Script Date: 01/31/2012 07:47:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateCNTemplate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateCNTemplate]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateContactCategories]    Script Date: 01/31/2012 07:47:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateContactCategories]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateContactCategories]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateContactEmails]    Script Date: 01/31/2012 07:47:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateContactEmails]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateContactEmails]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateContactFAQs]    Script Date: 01/31/2012 07:47:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateContactFAQs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateContactFAQs]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateContactLists]    Script Date: 01/31/2012 07:47:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateContactLists]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateContactLists]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateEnv]    Script Date: 01/31/2012 07:48:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateEnv]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateEnv]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 01/31/2012 07:48:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateProduct]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateProductCategoryDocument]    Script Date: 01/31/2012 07:48:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProductCategoryDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateProductCategoryDocument]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateProductDocument]    Script Date: 01/31/2012 07:48:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProductDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateProductDocument]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateProductLog]    Script Date: 01/31/2012 07:48:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProductLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateProductLog]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateProductNotes]    Script Date: 01/31/2012 07:48:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProductNotes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateProductNotes]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateProductProductGroup]    Script Date: 01/31/2012 07:48:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProductProductGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateProductProductGroup]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateracingGuests2011]    Script Date: 01/31/2012 07:49:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateracingGuests2011]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateracingGuests2011]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateRheemTeamServiceRequest]    Script Date: 01/31/2012 07:49:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateRheemTeamServiceRequest]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateRheemTeamServiceRequest]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateSEER]    Script Date: 01/31/2012 07:49:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateSEER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateSEER]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateSeries]    Script Date: 01/31/2012 07:49:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateSeries]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateSeries]
GO
USE [master]
GO

/****** Object:  StoredProcedure [dbo].[UpdateSeriesDocument]    Script Date: 01/31/2012 07:49:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateSeriesDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateSeriesDocument]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Updatetraining_class_registrations]    Script Date: 01/31/2012 07:49:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Updatetraining_class_registrations]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Updatetraining_class_registrations]
GO

USE [master]
GO

/****** Object:  StoredProcedure [dbo].[Updatetraining_classes]    Script Date: 01/31/2012 07:49:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Updatetraining_classes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Updatetraining_classes]
GO
