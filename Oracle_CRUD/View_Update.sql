
CREATE or replace procedure SYSTEM.UpdateView (
  film_name VARCHAR2,
  rating number
)
  IS BEGIN
  UPDATE good_film
    SET FilmRating = rating
    WHERE FilmName = film_name;
end;

-- --------------------------------------------------------
-- CONNECT VIEW AND FILM


CREATE or replace TRIGGER SYSTEM.UpdateViewTrigger
  INSTEAD OF UPDATE OR INSERT
  ON GOOD_FILM
    BEGIN

      UPDATE Film SET FilmRating = :new.FILMRATING
      WHERE FilmName = :new.FILMNAME;
    END;