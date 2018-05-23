-- -----------------------------------------------------
-- DELETE

CREATE PROCEDURE dbo.DeleteOrder_ (
  @ID INT
)
  AS BEGIN
    DELETE FROM Order_ WHERE ID = @ID
  END
