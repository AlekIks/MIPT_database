CREATE or replace FUNCTION SYSTEM.ReadOrder_ (
  id_ INT
)
  RETURN SYS_REFCURSOR IS
  ans sys_refcursor;
  BEGIN
    open ans for SELECT * FROM Order_ WHERE id_ = ID;
    return ans;
  END;