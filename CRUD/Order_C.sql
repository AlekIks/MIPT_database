-- --------------------------------------------------
-- CREATE

CREATE PROCEDURE dbo.CreateOrder_ (
  @Place INT,
  @Room INT,
  @CinemaName VARCHAR(MAX),
  @StartTime TIME,
  @CustomerName VARCHAR(255),
  @IsReserver BIT,
  @IsOccupied BIT,
  @FilmName VARCHAR(255),
  @Price INT
)
  AS BEGIN
  DECLARE @ChekingPlaceNumber INT
  SET @ChekingPlaceNumber = -1

  SELECT @ChekingPlaceNumber = PlaceNumber FROM Order_
    WHERE @CinemaName = CinemaName AND @Room = @Room
          AND @Place = PlaceNumber AND @StartTime = StartTime

  IF @ChekingPlaceNumber = -1
      INSERT INTO Order_ VALUES (@Place, @Room, @CinemaName,
                                 @StartTime, @CustomerName, @IsReserver,
                                 @IsOccupied, @FilmName, @Price)

  ELSE
    RAISERROR ('Это место уже занято', 16, 1)
  END
