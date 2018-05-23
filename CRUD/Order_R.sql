

-- -----------------------------------------------------
-- RETRIEVE

CREATE PROCEDURE dbo.GetOrder_ (
  @ID INT
)
  AS BEGIN
    DECLARE @Flag INT
    SET @Flag = -1

    SELECT @Flag = PlaceNumber FROM Order_ WHERE ID = @ID

    IF @Flag = -1
      SELECT * FROM Order_
    ELSE
      SELECT * FROM Order_ WHERE ID = @ID
  END

