-- ---------------------------------------------------------
-- ROW CHECK

DROP TRIGGER dbo.PlaceCheck
GO;


CREATE TRIGGER dbo.PlaceCheck
   ON  Place
   AFTER INSERT, UPDATE
AS
   IF UPDATE(PlaceNumber)
      BEGIN
        DECLARE @PlaceNumber INT;
        SELECT @PlaceNumber = PlaceNumber FROM inserted

        DECLARE @CinemaName VARCHAR(MAX)
        SELECT @CinemaName = CinemaName FROM inserted

        DECLARE @PlacesQuantity INT;
        SELECT @PlacesQuantity = PLacesQuantity FROM Room
                WHERE @CinemaName = Room.CinemaName

        IF (@PlaceNumber > @PlacesQuantity OR @PlaceNumber <= 0)
          BEGIN
              ROLLBACK TRANSACTION;
             RAISERROR ('Некорректный номер места.', 16, 1);
          END
      END
go;

-- --------------------------------------------------------
-- CHECK ROOMS IN CINEMA

DROP TRIGGER dbo.RoomNumberInCinemaCheck
GO;


  CREATE TRIGGER dbo.RoomNumberInCinemaCheck
    ON Room
    AFTER INSERT, UPDATE
  AS IF UPDATE(RoomNumberInCinema)
      BEGIN
        DECLARE @CinemaName VARCHAR(MAX)
        SELECT @CinemaName = CinemaName FROM inserted

        DECLARE @RoomQuantity INT
        SELECT @RoomQuantity = RoomsQuantity FROM Cinema
          WHERE @CinemaName = Cinema.CinemaName

        DECLARE @RoomNumber INT
        SELECT @RoomNumber = RoomNumberInCinema FROM inserted

        IF @RoomNumber > @RoomQuantity OR @RoomNumber <= 0
          BEGIN
            ROLLBACK TRANSACTION;
            PRINT 'Зала с таким номером не существует.';
          END
      END
go;
