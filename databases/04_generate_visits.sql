USE clinic
GO

IF NOT EXISTS(
    SELECT *
    FROM sys.objects
    WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('generate_visits')
)
  EXEC ('CREATE PROCEDURE generate_visits @n INT AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE generate_visits @n INT
AS
  BEGIN
    SET NOCOUNT ON;
    DECLARE @i INT = 0
    DECLARE @nr INT
    DECLARE @date DATE
    DECLARE @time TIME
    DECLARE @doctor BIGINT
    DECLARE @patient BIGINT
    DECLARE doc_cur CURSOR LOCAL FOR
      SELECT pesel from doctor order by newid()
    DECLARE pat_cur CURSOR LOCAL FOR
      SELECT pesel from patient order by newid()

    OPEN doc_cur
    OPEN pat_cur

    FETCH NEXT FROM doc_cur INTO @doctor
    FETCH NEXT FROM pat_cur INTO @patient

    WHILE @i < @n
      BEGIN
        SET @i = @i + 1
        SET @date = dateadd(DAY, (abs(CHECKSUM(newid())) % 3650) * -1, getdate())
        SET @time = dateadd(millisecond, (abs(CHECKSUM(newid())) % 86400000 + 1), convert(time, '08:00'))
        SET @nr = ABS(CHECKSUM(NewId())) % 30 + 1
        INSERT INTO visit(doctor, patient, date, time, nr) VALUES (
          @doctor,
          @patient,
          @date,
          @time,
          @nr
        )
        FETCH NEXT FROM doc_cur INTO @doctor
        FETCH NEXT FROM pat_cur INTO @patient
      END
    CLOSE doc_cur
    CLOSE pat_cur
    DEALLOCATE doc_cur
    DEALLOCATE pat_cur
  END
GO
