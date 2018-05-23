DROP PROCEDURE dbo.UpdateView
Go;


CREATE PROCEDURE dbo.UpdateView (
  @FilmName VARCHAR(MAX),
  @Rating INT
)
  AS BEGIN
  UPDATE [Films more popular than average]
    SET FilmRating = @Rating
    WHERE FilmName = @FilmName
end
GO;

-- --------------------------------------------------------
-- CONNECT VIEW AND FILM

DROP TRIGGER dbo.UpdateViewTrigger
Go;


CREATE TRIGGER dbo.UpdateViewTrigger
  ON [Films more popular than average]
  INSTEAD OF UPDATE
  AS IF UPDATE(FilmRating)
    BEGIN

      DECLARE @FilmName VARCHAR(MAX)
      DECLARE @FilmRating INT
      SELECT @FilmName = FilmName, @FilmRating = FilmRating FROM inserted

      UPDATE Film SET Film.FilmRating = @FilmRating
      WHERE FilmName = @FilmName
    END
