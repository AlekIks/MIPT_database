DROP FUNCTION dbo.CheckRoomInCinema
Go;


CREATE FUNCTION dbo.CheckRoomInCinema(
  @CinemaName VARCHAR(MAX)
)
 RETURNS INT AS
  BEGIN
    DECLARE @RoomCount INT
    SELECT @RoomCount = RoomsQuantity FROM Cinema WHERE @CinemaName = CinemaName
    RETURN @RoomCount;
  END
go

