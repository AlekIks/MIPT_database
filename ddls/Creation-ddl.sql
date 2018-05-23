DROP TABLE Order_;
DROP TABLE Session;
DROP TABLE Place;
DROP TABLE Room;
DROP TABLE Cinema;
DROP TABLE Film;

-- ---------------------------------------------------------------------
--   FILM

CREATE TABLE Film (
  FilmName VARCHAR(255) NOT NULL PRIMARY KEY,
  Durability TIME,
  FilmRating FLOAT NOT NULL,
      Genre VARCHAR(255),
      Age INT
);

-- ---------------------------------------------------------------------
--   CINEMA

CREATE TABLE Cinema (
  CinemaName VARCHAR(255) NOT NULL PRIMARY KEY,
  RoomsQuantity INT NOT NULL,
  CinemaAddress VARCHAR(255),
  CinemaRating FLOAT,
  CHECK (CinemaRating >= 0 AND CinemaRating <= 5)
);

-- ---------------------------------------------------------------------
--  ROOM

CREATE TABLE Room (
  CinemaName VARCHAR(255) FOREIGN KEY REFERENCES Cinema (CinemaName),
  RoomNumberInCinema INT NOT NULL,
  PlacesQuantity INT,

  CHECK (RoomNumberInCinema <= dbo.CheckRoomInCinema(CinemaName)),
  CONSTRAINT RoomIdentification PRIMARY KEY (CinemaName, RoomNumberInCinema)
);

-- ---------------------------------------------------------------------
-- PLACE

CREATE TABLE Place (
  PlaceNumber INT NOT NULL,
  RoomNumberInCinema INT,
  CinemaName VARCHAR(255),
  RowNumber INT,
  ColumnNumber INT,

  CONSTRAINT DetectRoomForPlace FOREIGN KEY (CinemaName, RoomNumberInCinema)
  REFERENCES Room(CinemaName, RoomNumberInCinema),

  CONSTRAINT PlaceIdentification PRIMARY KEY (PlaceNumber, RoomNumberInCinema, CinemaName)
);


-- ---------------------------------------------------------------------
-- SESSION

CREATE TABLE Session (
  RoomNumberInCinema INT,
  CinemaName VARCHAR(255),
  FilmName VARCHAR(255) FOREIGN KEY REFERENCES Film (FilmName),
  StartTime TIME,
  EndTime TIME,


  CONSTRAINT DetectPLaceForSession FOREIGN KEY (CinemaName, RoomNumberInCinema)
  REFERENCES Room(CinemaName, RoomNumberInCinema),

  CONSTRAINT SessionIdentification PRIMARY KEY (RoomNumberInCinema, CinemaName, StartTime)
);


-- ---------------------------------------------------------------------
-- ORDER


CREATE TABLE Order_ (
  ID INT IDENTITY (1, 1),
  PlaceNumber INT NOT NULL,
  RoomNumberInCinema INT,
  CinemaName VARCHAR(255),
  StartTime TIME,
  CustomerName VARCHAR(255),
  IsReserver BIT,
  IsOccupied BIT,
  FilmName VARCHAR(255),
  Price INT,

  CONSTRAINT DetectSessionForOrder FOREIGN KEY (RoomNumberInCinema, CinemaName, StartTime)
  REFERENCES Session(RoomNumberInCinema, CinemaName, StartTime),

  CONSTRAINT DetectPlaceForOrder FOREIGN KEY (PlaceNumber, RoomNumberInCinema, CinemaName)
  REFERENCES Place(PlaceNumber, RoomNumberInCinema, CinemaName),

  CONSTRAINT OrderIdentification PRIMARY KEY (PlaceNumber, RoomNumberInCinema, CinemaName,
  StartTime)
)
