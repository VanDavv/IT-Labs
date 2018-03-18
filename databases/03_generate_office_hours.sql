USE clinic
GO

IF NOT EXISTS(
    SELECT *
    FROM sys.objects
    WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('generate_office_hours')
)
  EXEC ('CREATE PROCEDURE generate_office_hours() AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE generate_office_hours()
AS
  BEGIN

    DECLARE @i INT = 0
    DECLARE @starttime TIME
    DECLARE @endtime TIME
    DECLARE @doctor BIGINT
    DECLARE cur CURSOR LOCAL FOR
      SELECT pesel from doctor order by newid()

    FETCH NEXT FROM cur INTO @doctor

    WHILE @@FETCH_STATUS = 0
      BEGIN
        SET @i = 0
        WHILE @i < 5
          BEGIN
            SET @i = @i + 1
            SET @starttime = dateadd(millisecond, (abs(CHECKSUM(newid())) % 7200000 + 1), convert(time, '08:00'))
            SET @endtime = dateadd(millisecond, (abs(CHECKSUM(newid())) % 7200000 + 1), convert(time, '14:00'))

            INSERT INTO office_hours VALUES (
              @doctor,
              @i,
              @starttime,
              @endtime
            )
          END
        FETCH NEXT FROM cur INTO @doctor
      END
    CLOSE cur
    DEALLOCATE cur
  END
GO
