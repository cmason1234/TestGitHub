USE rheem;

DROP FUNCTION IF Exists LongitudePlusDistance;

DELIMITER $$
Create Function LongitudePlusDistance
    (StartLongitude Float,
    StartLatitude Float,
    Distance Float)
Returns Float Deterministic
Begin
    Return (Select StartLongitude + Sqrt(Distance * Distance / (4784.39411916406 * Cos(2 * StartLatitude / 114.591559026165) * Cos(2 * StartLatitude / 114.591559026165))));
End$$

DELIMITER ;

