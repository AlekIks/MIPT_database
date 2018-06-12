ALTER SESSION SET CURRENT_SCHEMA=SYSTEM;

DROP SEQUENCE seq;
DROP TABLE Order_;
DROP TABLE Session_;
DROP TABLE Place;
DROP TABLE Room;
DROP TABLE Cinema;
DROP TABLE Film;


-- ---------------------------------------------------------------------
--   FILM


CREATE TABLE Film (
  FilmName VARCHAR(255) NOT NULL PRIMARY KEY,
  Durability TIMESTAMP,
  FilmRating number(3, 2) NOT NULL,
  Genre VARCHAR(255),
  Age number(2, 0)
);

-- ---------------------------------------------------------------------
--   CINEMA

CREATE TABLE Cinema (
		CinemaName varchar2(50) PRIMARY KEY,
		RoomsQuantity number(9, 0) NOT NULL,
		CinemaAddress varchar2(255),
		CinemaRating number(3, 2)
);


-- ---------------------------------------------------------------------
--   ROOM


CREATE TABLE Room (
  CinemaName varchar2(255),
  RoomNumberInCinema number(9, 0) NOT NULL,
  PlacesQuantity number(9, 0),

  -- CHECK (RoomNumberInCinema <= CheckRoomInCinema(CinemaName)),
  CONSTRAINT RoomIdentification PRIMARY KEY (CinemaName, RoomNumberInCinema),
  CONSTRAINT RoomDependenceFromCinema FOREIGN KEY (CinemaName) REFERENCES Cinema (CinemaName)
);


-- ---------------------------------------------------------------------
--   PLACE


CREATE TABLE Place (
  PlaceNumber INT NOT NULL,
  RoomNumberInCinema number(9, 0),
  CinemaName varchar2(255),
  RowNumber number(9, 0),
  ColumnNumber number(9, 0),

  CONSTRAINT DetectRoomForPlace FOREIGN KEY (CinemaName, RoomNumberInCinema)
  REFERENCES Room(CinemaName, RoomNumberInCinema),

  CONSTRAINT PlaceIdentification PRIMARY KEY (PlaceNumber, RoomNumberInCinema, CinemaName)
);


-- ---------------------------------------------------------------------
--   SESSION_


CREATE TABLE Session_ (
  RoomNumberInCinema INT,
  CinemaName VARCHAR2(255),
  FilmName VARCHAR2(255),
  StartTime TIMESTAMP,
  EndTime TIMESTAMP,


  CONSTRAINT DetectPLaceForSession FOREIGN KEY (CinemaName, RoomNumberInCinema)
  REFERENCES Room(CinemaName, RoomNumberInCinema),

  CONSTRAINT SessionIdentification PRIMARY KEY (RoomNumberInCinema, CinemaName, StartTime),

  CONSTRAINT SessionIdentificationFromFilm FOREIGN KEY (FilmName)  REFERENCES
  Film(FilmName)
);


-- ---------------------------------------------------------------------
--   ORDER_


CREATE SEQUENCE seq;

CREATE TABLE Order_ (
  ID integer NOT NULL PRIMARY KEY,
  PlaceNumber INT NOT NULL,
  RoomNumberInCinema INT,
  CinemaName VARCHAR2(255),
  StartTime TIMESTAMP,
  CustomerName VARCHAR2(255),
  IsReserver number(1, 0),
  IsOccupied number(1, 0),
  FilmName VARCHAR2(255),
  Price INT,

  CONSTRAINT DetectSessionForOrder FOREIGN KEY (RoomNumberInCinema, CinemaName, StartTime)
  REFERENCES Session_(RoomNumberInCinema, CinemaName, StartTime),

  CONSTRAINT DetectPlaceForOrder FOREIGN KEY (PlaceNumber, RoomNumberInCinema, CinemaName)
  REFERENCES Place(PlaceNumber, RoomNumberInCinema, CinemaName),

  CONSTRAINT OrderIdentification unique (PlaceNumber, RoomNumberInCinema, CinemaName,
  StartTime)
);

