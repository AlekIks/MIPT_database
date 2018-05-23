DROP FUNCTION dbo.TimeIsLessOrEqual
GO;


CREATE FUNCTION dbo.TimeIsLessOrEqual (
  @FirstTime TIME,
  @SecondTime Time
)
  RETURNS BIT AS
  BEGIN
    DECLARE @Hours1 INT;
    DECLARE @Minutes1 INT;

     SELECT @Hours1 = DATEPART(HOUR, @FirstTime)
     SELECT @Minutes1 = DATEPART(MINUTE, @FirstTime)

    DECLARE @Hours2 INT;
    DECLARE @Minutes2 INT;

     SELECT @Hours2 = DATEPART(HOUR, @SecondTime)
     SELECT @Minutes2 = DATEPART(MINUTE, @SecondTime)

    DECLARE @Ans BIT

    IF (@Hours1 < @Hours2)
      SET @Ans = 1
    ELSE
      BEGIN
        IF (@Hours1 = @Hours2 AND @Minutes1 <= @Minutes2)
          SET @Ans = 1
        ELSE
          SET @Ans = 0
      END

    RETURN @Ans
  END