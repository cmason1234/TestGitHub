USE [Products]
GO


IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'idxProdDocDocID' AND object_id = OBJECT_ID('ProductDocument'))
BEGIN
    CREATE NONCLUSTERED INDEX idxProdDocDocID
        ON [dbo].[ProductDocument] ([ProductID])
END
GO
