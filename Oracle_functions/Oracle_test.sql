-- ---------------------------------------------------------
-- ряд 2 места в первом зале 'Kinopark 7 IMAX Keruen'


SELECT SYSTEM.GETROWNUMBER(2, 1, 'Kinopark 7 IMAX Keruen')
  as couse_id from dual;


-- ---------------------------------------------------------
-- столбец 63 места в первом зале 'Kinopark 7 IMAX Keruen'


SELECT SYSTEM.GETCOLUMNNUMBER(63, 1, 'Kinopark 7 IMAX Keruen')
  as couse_id from dual;


-- ---------------------------------------------------------
-- цена на сеанс в зале 2 кинотеатра 'Kinopark 7 IMAX Keruen', место 32, начало в 10.19


SELECT SYSTEM.GetPrice('Kinopark 7 IMAX Keruen', 2, 17, '26-06-2018 10:19:00')
  AS price from dual;

-- ---------------------------------------------------------
-- создай новый заказ и прочти

  select * from ORDER_;

BEGIN
  SYSTEM.CREATEORDER_(2, 15, 6, 'Kinopark 7 IMAX Keruen',
                      '26-06-2018 19:04:00', NULL, 1, 0, 'Немыслимое письмо',
                      SYSTEM.GETPRICE('Kinopark 7 IMAX Keruen', 6, 15, '26-06-2018 19:04:00'));
end;

  select * from ORDER_;

-- ---------------------------------------------------------
-- измени заказ

BEGIN
  SYSTEM.UPDATEORDER_(2, 15, 6, 'Kinopark 7 IMAX Keruen',
                       '26-06-2018 19:04:00', 'Владимир Путин', 1, 0, 'Немыслимое письмо',
                       SYSTEM.GETPRICE('Kinopark 7 IMAX Keruen', 6, 15, '26-06-2018 19:04:00'),
                       'CUSTOME_BY_ID');
end;

select * from order_;

-- ---------------------------------------------------------
-- удали заказ

BEGIN
  SYSTEM.DELETEORDER_(2);
end;

  select * from order_;

-- ---------------------------------------------------------
-- покажи view

BEGIN
  SYSTEM.UPDATEVIEW('Героическое расследование', 4.65);
end;

SELECT * FROM GOOD_FILM;

BEGIN
  SYSTEM.UPDATEVIEW('Героическое расследование', 2);
end;

SELECT * FROM GOOD_FILM;
SELECT FILMNAME, FILMRATING FROM FILM;

-- ---------------------------------------------------------
-- Запросы

SELECT avg(FILMRATING) from FILM;
