Use [RheemDB]
GO

Update EC_Forecast set Y1DecAllocated=1 where Y1DecAllocated is null and GDPYear<2012
Update EC_Forecast set Y2JanAllocated=1 where Y2JanAllocated is null and GDPYear<2012
Update EC_Forecast set Y2FebAllocated=1 where Y2FebAllocated is null and GDPYear<2012
Update EC_Forecast set Y2MarAllocated=1 where Y2MarAllocated is null and GDPYear<2012
Update EC_Forecast set Y2AprAllocated=1 where Y2AprAllocated is null and GDPYear<2012
Update EC_Forecast set Y2MarAllocated=1 where Y2MayAllocated is null and GDPYear<2012
Update EC_Forecast set Y2JunAllocated=1 where Y2JunAllocated is null and GDPYear<2012
Update EC_Forecast set Y2JulAllocated=1 where Y2JulAllocated is null and GDPYear<2012
Update EC_Forecast set Y2AugAllocated=1 where Y2AugAllocated is null and GDPYear<2012
Update EC_Forecast set Y2SepAllocated=1 where Y2SepAllocated is null and GDPYear<2012
Update EC_Forecast set Y2OctAllocated=1 where Y2OctAllocated is null and GDPYear<2012
Update EC_Forecast set Y2NovAllocated=1 where Y2NovAllocated is null and GDPYear<2012

