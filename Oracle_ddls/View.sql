create or replace view good_film
  as select FilmName, FilmRating
    from Film
    where FILMRATING > 3;
