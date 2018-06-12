create or replace procedure DeleteOrder_ (
  id_ INT
)
  is begin
  delete from Order_ where ID = id_;
end;