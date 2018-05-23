
  DECLARE @statement NVARCHAR;

  DECLARE @StartTime TIME;
  SET @StartTime = '11:00'

  DECLARE @time TIME
  SET @time = '13:00'

  declare @sqlCommand VARCHAR(MAX)
  SET @sqlCommand = 'SELECT FilmName FROM Films
            WHERE dbo.TimeIsLessOrEqual(@StartTime, @time) = 1'

  EXECUTE sp_executesql @sqlCommand,
            N'@time TIME',
            @time = @time

  GO;