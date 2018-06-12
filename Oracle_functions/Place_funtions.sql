-- ---------------------------------------------------------------------
--   sqrt

create or replace function SYSTEM.koren (
  num INT
)
  RETURN INT
  IS
  CURSOR Kor IS SELECT SQRT(num) FROM dual;
  ans INT;
  begin
    open Kor;
    fetch Kor into ans;
    close Kor;
    return ans;
  end;

-- ---------------------------------------------------------------------
--   sqrt

create or replace function SYSTEM.modul (
  divided INT,
  mod INT
)
RETURN INT
IS
  CURSOR md IS SELECT MOD(divided, mod) FROM dual;
  ans INT;
  begin
    open md;
    fetch md into ans;
    close md;
    return ans;
  end;


-- ---------------------------------------------------------------------
--   ROW

create or replace FUNCTION        GetRowNumber
  ( place_number in INT,
    room_number_in_cinema in INT,
    cinema_name in VARCHAR2 )
  RETURN int
IS
    places_quantity INT;

    CURSOR PQ IS
      SELECT PLacesQuantity
      FROM Room
      WHERE cinema_name = CinemaName AND room_number_in_cinema = RoomNumberInCinema;

    places_in_row INT;

    row_number INT;

BEGIN
    OPEN PQ;
    FETCH PQ INTO places_quantity;

    places_in_row := SYSTEM.koren(places_quantity);

    row_number := place_number / places_in_row;


    IF SYSTEM.modul(place_number, places_in_row) <> 0 then
        row_number := row_number + 1;
    end if;

    close PQ;
RETURN row_number;
END;



-- ---------------------------------------------------------------------
--   COLUMN
create or replace FUNCTION GetColumnNumber(
  place_number in INT,
  room_number_in_cinema in INT,
  cinema_name in VARCHAR2
)
RETURN int
 IS
  places_quantity INT;

  CURSOR PQ IS
    SELECT PLacesQuantity
    FROM Room
    WHERE cinema_name = CinemaName AND room_number_in_cinema = RoomNumberInCinema;

  places_in_row INT;
  column_number INT;

  BEGIN

    OPEN PQ;
    FETCH PQ INTO places_quantity;

    places_in_row := SYSTEM.koren(places_quantity);

    column_number := SYSTEM.modul(place_number, places_in_row);

    IF column_number = 0 then
        column_number := places_in_row;
    end if;

    RETURN column_number;
  END;
/




