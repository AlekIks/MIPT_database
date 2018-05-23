-- Формула расчета цены места на сеанс:
--
-- |==================================|
-- | Коэффициенты цены:               |
-- |                                  |
-- | Max рейтинг фильма______________5|
-- | Max рейтинг кинотеатра__________5|
-- | VIP место (внутри                |
-- | квадрата [PQ\3;2PQ\3])__________3|
-- | Обычное место___________________1|
-- | Вечернее время сеанса            |
-- | (между 17.00 и 3.59)____________3|
-- | Дневное время сеанса             |
-- | (между 13.00 и 16.59)___________2|
-- | Утреннее время сеанса            |
-- | (между 4.00 и 12.59)____________1|
-- |                                  |
-- | ---------------------------------|
-- | Недостижимые макс показатели:    |
-- |                                  |
-- | 100% max коэф__________________20|
-- | Max цена___________________2000тг|
-- |                                  |
-- | ---------------------------------|
-- | Формула расчета цены:            |
-- |                                  |
-- | S = t * 100, где t - сумма       |
-- | необходимых коэффициентов        |
-- |                                  |
-- |==================================|


DROP FUNCTION dbo.GetPrice
GO;


CREATE FUNCTION dbo.GetPrice(
  @CinemaName VARCHAR(MAX),
  @RoomNumberInCinema INTEGER,
  @PlaceNumber INTEGER,
  @StartTime TIME
)
RETURNS INT AS
  BEGIN

    DECLARE @Koefficient INT
    SET @Koefficient = 1;

    -- ------------------------------------------
    -- VIP

    DECLARE @PLacesQuantity INT

    SELECT @PLacesQuantity = PLacesQuantity FROM Room
      WHERE @CinemaName = CinemaName AND @RoomNumberInCinema = RoomNumberInCinema

    DECLARE @RowNumber INT
    SET @RowNumber = dbo.GetRowNumber(@PlaceNumber, @RoomNumberInCinema, @CinemaName);

    DECLARE @ColumnNumber INT
    SET @ColumnNumber = dbo.GetColumnNumber(@PlaceNumber, @RoomNumberInCinema, @CinemaName);

    IF @ColumnNumber < 2 * @PLacesQuantity / 3 AND @ColumnNumber > @PLacesQuantity / 3 AND
      @RowNumber < 2 * @PLacesQuantity / 3 AND @RowNumber > @PLacesQuantity / 3
      BEGIN
        SET @Koefficient = 3;
      END

    -- ------------------------------------------
    -- TIME

    IF (dbo.TimeIsLessOrEqual(@StartTime, '4:00') = 0 AND
       dbo.TimeIsLessOrEqual(@StartTime, '13:00') = 1)
      BEGIN
        SET @Koefficient = @Koefficient + 1
      END
    IF (dbo.TimeIsLessOrEqual(@StartTime, '13:00') = 0 AND
       dbo.TimeIsLessOrEqual(@StartTime, '17:00') = 1)
      BEGIN
        SET @Koefficient = @Koefficient + 2
      END
    IF (dbo.TimeIsLessOrEqual(@StartTime, '17:00') = 0 OR
       dbo.TimeIsLessOrEqual(@StartTime, '4:00') = 1)
      BEGIN
        SET @Koefficient = @Koefficient + 3
      END

    -- -----------------------------------------
    -- FILM RATING

    DECLARE @FilmName VARCHAR(MAX)
    SELECT @FilmName = FilmName FROM Session
          WHERE @StartTime = StartTime AND
            @RoomNumberInCinema = RoomNumberInCinema AND
            @CinemaName = CinemaName

    DECLARE @FilmRating INT
    SELECT @FilmRating = FilmRating FROM Film
          WHERE @FilmName = FilmName

    SET @Koefficient = @Koefficient + @FilmRating

    -- -----------------------------------------
    -- CINEMA RATING

    DECLARE @CinemaRating INT
    SELECT @CinemaRating = CinemaRating FROM Cinema
          WHERE @CinemaName = CinemaName

    -- -----------------------------------------

    RETURN @Koefficient * 100
  END
go
