create or replace FUNCTION        GetPrice(
  cinema_name IN VARCHAR2,
  room_number_in_cinema in  number,
  place_number in number,
  start_time in TIMESTAMP
)
RETURN INT IS
  koefficient number;
  places_quantity number;

  CURSOR PQ IS SELECT PLacesQuantity
    FROM Room
    WHERE cinema_name = CinemaName AND
          room_number_in_cinema = RoomNumberInCinema;

  film_name VARCHAR2(255);
  CURSOR FN IS SELECT FilmName
   FROM Session_
   WHERE start_time = StartTime AND
   room_number_in_cinema = RoomNumberInCinema AND
   cinema_name = CinemaName;

  cinema_rating number;
  CURSOR CR IS SELECT CinemaRating
    FROM Cinema
    WHERE cinema_name = CinemaName;

  film_rating number;
  row_number number;
  column_number number;

  BEGIN

    koefficient := 1;

    -- ------------------------------------------
    -- VIP

    OPEN PQ;
    FETCH PQ INTO places_quantity;

    row_number := GETROWNUMBER(place_number, room_number_in_cinema, cinema_name);
    column_number := GetColumnNumber(place_number, room_number_in_cinema, cinema_name);


    IF column_number < 2 * places_quantity / 3 AND column_number > places_quantity / 3 AND
      row_number < 2 * places_quantity / 3 AND row_number > places_quantity / 3 then
        koefficient := 3;
      end if;

    -- ------------------------------------------
    -- TIME

        koefficient := koefficient + 3;


    -- -----------------------------------------
    -- FILM RATING


    -- -----------------------------------------
    -- CINEMA RATING

    OPEN CR;
    FETCH CR INTO cinema_rating;
    koefficient := koefficient + cinema_rating;

    -- -----------------------------------------
    koefficient := koefficient * 100;
    RETURN koefficient;
    end;
/

