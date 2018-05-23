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

    IF @StartTime >= '4.00' AND @StartTime <= '12.59'
      BEGIN
        SET @Koefficient = @Koefficient + 1
        RAISERROR ('Morning', 16, 1)
      END
    IF @StartTime >= '13.00' AND @StartTime <= '16.59'
      BEGIN
        SET @Koefficient = @Koefficient + 2
      END
    IF @StartTime >= '17.00' AND @StartTime <= '3.59'
      BEGIN
        SET @Koefficient = @Koefficient + 3
      END

    -- -----------------------------------------
    -- CHECKING

    RETURN @Koefficient * 100
  END
go

