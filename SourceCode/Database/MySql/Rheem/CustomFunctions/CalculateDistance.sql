USE rheem;

DROP FUNCTION IF Exists CalculateDistance;

DELIMITER $$
CREATE Function CalculateDistance
    (long1 Decimal(8,5),
    lat1   Decimal(8,5),
    long2  Decimal(8,5),
    lat2   Decimal(8,5))
Returns Float Deterministic
Begin
Declare R Float(8);
      Declare dLat Float(18);
      Declare dLon Float(18);
      Declare a Float(18);
      Declare c Float(18);
      Declare d Float(18);

      Select Radians(lat2 - lat1) into dLat;

      Select Radians(long2 - long1) into dLon;

      Select Sin(dLat / 2) * Sin(dLat / 2) 
                 + Cos(Radians(lat1)) * Cos(Radians(lat2)) * Sin(dLon / 2) * Sin(dLon / 2) into a;
      select 2 * Asin(Min(Sqrt(a))) into c;

      Return 3956.55 * c; 
 
End$$

DELIMITER ;



