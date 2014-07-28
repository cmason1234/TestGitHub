USE rheem;

DROP FUNCTION IF Exists LatitudePlusDistance;

DELIMITER $$
Create Function LatitudePlusDistance(StartLatitude Float, Distance Float) Returns Float Deterministic
Begin
    Return (Select StartLatitude + Sqrt(Distance * Distance / 4766.8999155991));
End$$

DELIMITER ;
