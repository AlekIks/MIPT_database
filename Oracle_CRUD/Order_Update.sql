-- -----------------------------------------------------
-- UPDATE


CREATE OR REPLACE PROCEDURE SYSTEM.UpdateOrder_ (
  ID_ INT,
  place INT,
  room INT,
  cinema_name VARCHAR2,
  start_time TIMESTAMP,
  customer_name VARCHAR2,
  is_reserved number,
  is_occupied number,
  film_name VARCHAR2,
  price_ INT,
  update_type VARCHAR2
)
  AS BEGIN
    IF update_type = 'ALL_BY_ID' then
        UPDATE Order_ SET 
          CustomerName = customer_name,
          IsReserver = is_reserved, IsOccupied = is_occupied,
          FilmName = film_name, Price = price_, PlaceNumber = place, RoomNumberInCinema = room,
          CinemaName = cinema_name, StartTime = start_time
          WHERE ID = id_;
      END if;
      
    IF update_type = 'ALL_BY_PK' then
        UPDATE Order_ SET 
          CustomerName = customer_name,
          IsReserver = is_reserved, IsOccupied = is_occupied,
          FilmName = film_name, Price = price_
            WHERE PlaceNumber = place AND RoomNumberInCinema = room AND
          CinemaName = cinema_name AND StartTime = start_time;
      END if;

    IF update_type = 'CUSTOME_BY_ID' then
        UPDATE Order_ SET CustomerName = customer_name
        WHERE ID = id_;
      end if;

    IF update_type = 'STATUS_BY_ID' then
        UPDATE Order_ SET IsOccupied = is_occupied,
          IsReserver = is_reserved
        WHERE ID = id_;
      end if;
  END;
