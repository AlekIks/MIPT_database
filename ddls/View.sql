CREATE VIEW [Films more popular than average] AS
SELECT FilmName, FilmRating
  FROM Film
  WHERE FilmRating > (SELECT AVG(FilmRating) FROM Film)
