USE clinic
GO

IF NOT EXISTS(
    SELECT *
    FROM sys.objects
    WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('generate_doctors')
)
  EXEC ('CREATE PROCEDURE generate_doctors @n int AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE generate_doctors @n INT
AS
  BEGIN
    SET NOCOUNT ON;
    DECLARE @i INT = 0
    DECLARE @first_name INT
    DECLARE @last_name INT
    DECLARE @specialization INT
    DECLARE @degree INT
    DECLARE @fulltime INT
    DECLARE @startdate DATE
    DECLARE @phone BIGINT
    DECLARE @pesel1 INT, @pesel2 INT, @pesel3 INT, @pesel4 INT

    WHILE @i < @n
      BEGIN
        SET @i = @i + 1
        SET @first_name = ABS(CHECKSUM(NewId())) % 10 + 1
        SET @last_name = ABS(CHECKSUM(NewId())) % 10 + 1
        SET @specialization = ABS(CHECKSUM(NewId())) % 10 + 1
        SET @degree = ABS(CHECKSUM(NewId())) % 5 + 1
        SET @fulltime = ABS(CHECKSUM(NewId())) % 2
        SET @startdate = dateadd(DAY, (abs(CHECKSUM(newid())) % 3650) * -1, getdate())
        SET @phone = ABS(CHECKSUM(NewId())) % 90000000 + 100000000
        SET @pesel1 = (ABS(CHECKSUM(NewId()))) % 80 + 20
        SET @pesel2 = (ABS(CHECKSUM(NewId()))) % 9 + 1
        SET @pesel3 = (ABS(CHECKSUM(NewId()))) % 20 + 10
        SET @pesel4 = (ABS(CHECKSUM(NewId()))) % 90000 + 10000

        INSERT INTO doctor(pesel, name, spec, degree, fulltime, started_working_date, phone) VALUES (
          cast(@pesel1 AS VARCHAR) + '0' + cast(@pesel2 AS VARCHAR) + cast(@pesel3 AS VARCHAR) + cast(@pesel4 AS VARCHAR),
          choose(@first_name, 'Adam', 'Marek', 'Tomek', 'Horacy', 'Łukasz', 'Mateusz', 'Olgierd', 'Michał', 'Dawid', 'Gerard') + choose(@last_name, 'Adamski', 'Marecki', 'Tomasiuk', 'Horacyński', 'Piłatowski', 'Iwaniec', 'Olgierdowicz', 'Michałowicz', 'Davidovich', 'Kruci'),
          @specialization,
          choose(@degree, 'młodszy', 'dr. n. med.', 'stażysta', 'dr.', 'prof.'),
          @fulltime,
          @startdate,
          '+48' + cast(@phone AS VARCHAR)
        )
      END
  END
GO
