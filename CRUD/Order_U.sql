-- -----------------------------------------------------
-- UPDATE


CREATE PROCEDURE dbo.UpdateOrder_ (
  @ID INT,
  @Place INT,
  @Room INT,
  @CinemaName VARCHAR(MAX),
  @StartTime TIME,
  @CustomerName VARCHAR(255),
  @IsReserver BIT,
  @IsOccupied BIT,
  @FilmName VARCHAR(255),
  @Price INT,
  @UpdateType VARCHAR(MAX)
)
  AS BEGIN
    IF @UpdateType = 'ALL_BY_ID'
      BEGIN
        UPDATE Order_ SET CustomerName = @CustomerName,
          IsReserver = @IsReserver, IsOccupied = @IsOccupied,
          FilmName = @FilmName, Price = @Price, PlaceNumber = @Place, RoomNumberInCinema = @Room,
          CinemaName = @CinemaName, StartTime = @StartTime
          WHERE ID = @ID
      END
    IF @UpdateType = 'ALL_BY_PK'
      BEGIN
        UPDATE Order_ SET CustomerName = @CustomerName,
          IsReserver = @IsReserver, IsOccupied = @IsOccupied,
          FilmName = @FilmName, Price = @Price
            WHERE PlaceNumber = @Place AND RoomNumberInCinema = @Room AND
          CinemaName = @CinemaName AND StartTime = @StartTime
      END
    IF @UpdateType = 'CUSTOME_BY_ID'
      BEGIN
        UPDATE Order_ SET CustomerName = @CustomerName
        WHERE ID = @ID
      end
    IF @UpdateType = 'STATUS_BY_ID'
      BEGIN
        UPDATE Order_ SET IsOccupied = @IsOccupied,
          IsReserver = @IsReserver
        WHERE ID = @ID
      end
  END
