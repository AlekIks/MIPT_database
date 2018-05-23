-- ---------------------------------------------------------------------
--   ROW
DROP FUNCTION dbo.GetRowNumber
GO;


CREATE FUNCTION dbo.GetRowNumber(
  @PlaceNumber INTEGER,
  @RoomNumberInCinema INTEGER,
  @CinemaName VARCHAR(MAX)
)
RETURNS INT AS
  BEGIN
    DECLARE @PLacesQuantity INT

    SELECT @PLacesQuantity = PLacesQuantity FROM Room
      WHERE @CinemaName = CinemaName AND @RoomNumberInCinema = RoomNumberInCinema

    DECLARE @PlacesInRow INT;
    SET @PlacesInRow = SQRT(@PLacesQuantity);

    DECLARE @RowNumber INT;
    SET @RowNumber = @PlaceNumber / @PlacesInRow;

    IF @PlaceNumber % @PlacesInRow <> 0
      BEGIN
        SET @RowNumber += 1
      END

    RETURN @RowNumber;
  END
go


-- ---------------------------------------------------------------------
--   COLUMN
DROP FUNCTION dbo.GetColumnNumber
GO;


CREATE FUNCTION dbo.GetColumnNumber(
  @PlaceNumber INTEGER,
  @RoomNumberInCinema INTEGER,
  @CinemaName VARCHAR(MAX)
)
RETURNS INT AS
  BEGIN
    DECLARE @PLacesQuantity INT

    SELECT @PLacesQuantity = PLacesQuantity FROM Room
      WHERE @CinemaName = CinemaName AND @RoomNumberInCinema = RoomNumberInCinema


    DECLARE @PlacesInRow INT;
    SET @PlacesInRow = SQRT(@PlacesQuantity)

    DECLARE @ColumnNumber INT;
    SET @ColumnNumber = @PlaceNumber % @PlacesInRow

    IF @ColumnNumber = 0
      BEGIN
        SET @ColumnNumber = @PlacesInRow
      END

    RETURN @ColumnNumber;
  END
GO

