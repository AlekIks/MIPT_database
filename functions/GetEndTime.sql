DROP FUNCTION dbo.GetEndTime
go


CREATE FUNCTION dbo.GetEndTime(
  @FilmName VARCHAR(MAX),
  @StartTime TIME
)
 RETURNS TIME AS
  BEGIN
    DECLARE @Durability TIME;
    SELECT @Durability = Durability FROM Film WHERE @FilmName = FilmName

     DECLARE @Hours INT;
     DECLARE @Minutes INT;

     SELECT @Hours = DATEPART(HOUR, @Durability)
     SELECT @Minutes = DATEPART(MINUTE, @Durability)

     DECLARE @EndTime TIME;

     SET @EndTime = DATEADD(HOUR, @Hours, @StartTime)
     SET @EndTime = DATEADD(MINUTE, @Minutes, @EndTime)
     RETURN @EndTime;
  END
go
