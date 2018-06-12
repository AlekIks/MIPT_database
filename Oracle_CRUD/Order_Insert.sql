CREATE OR REPLACE PROCEDURE SYSTEM.CreateOrder_ (
  id in INT,
  place in INT,
  room in INT,
  cinema_name in VARCHAR2,
  start_time in TIMESTAMP,
  customer_name in VARCHAR2,
  is_reserver in number,
  is_occupied in number,
  film_name in VARCHAR2,
  price in INT
)
  as
  begin
      INSERT INTO Order_ VALUES (id, place, room, cinema_name,
                                 start_time, customer_name, is_reserver,
                                 is_occupied, film_name, price);
      COMMIT;
  END;