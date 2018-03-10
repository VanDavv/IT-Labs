USE master
GO

IF exists(
    SELECT *
    FROM sys.databases
    WHERE name = 'clinic'
)
  DROP DATABASE clinic
GO

CREATE DATABASE clinic
GO

USE clinic
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'doctor' AND xtype = 'U'
)
  CREATE TABLE doctor (
    pesel                BIGINT,
    name                 TEXT,
    spec                 INT,
    degree               TEXT,
    fulltime             BIT,
    started_working_date DATE,
    phone                TEXT
  )
GO

IF NOT EXISTS(
    SELECT *
    FROM sys.objects
    WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('generate_doctors')
)
  EXEC ('CREATE PROCEDURE generate_doctors(@n int output) AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE generate_doctors(@n INT)
AS
  BEGIN

    DECLARE @i INT = 0
    DECLARE @name INT
    DECLARE @specialization INT
    DECLARE @degree INT
    DECLARE @fulltime INT
    DECLARE @startdate DATE
    DECLARE @phone BIGINT
    DECLARE @pesel1 INT, @pesel2 INT, @pesel3 INT, @pesel4 INT

    WHILE @i < @n
      BEGIN
        SET @i = @i + 1
        SET @name = ABS(CHECKSUM(NewId())) % 10 + 1
        SET @specialization = ABS(CHECKSUM(NewId())) % 10 + 1
        SET @degree = ABS(CHECKSUM(NewId())) % 5 + 1
        SET @fulltime = ABS(CHECKSUM(NewId())) % 2
        SET @startdate = dateadd(DAY, (abs(CHECKSUM(newid())) % 3650) * -1, getdate())
        SET @phone = ABS(CHECKSUM(NewId())) % 90000000 + 100000000
        SET @pesel1 = (ABS(CHECKSUM(NewId()))) % 80 + 20
        SET @pesel2 = (ABS(CHECKSUM(NewId()))) % 9 + 1
        SET @pesel3 = (ABS(CHECKSUM(NewId()))) % 20 + 10
        SET @pesel4 = (ABS(CHECKSUM(NewId()))) % 90000 + 10000

        INSERT INTO doctor VALUES (
          cast(@pesel1 AS VARCHAR) + '0' + cast(@pesel2 AS VARCHAR) + cast(@pesel3 AS VARCHAR) +
          cast(@pesel4 AS VARCHAR),
          choose(@name, 'Adam Adamski', 'Marek Marecki', 'Tomek Tomasiuk', 'Horacy Horacyński', 'Łukasz Piłatowski',
                 'Mateusz Iwaniec', 'Olgierd Olgierdowicz', 'Michał Michałowicz', 'Dawid Davidovich', 'Gerard Kruci'),
          @specialization,
          choose(@degree, 'młodszy', 'dr. n. med.', 'stara lucka', 'dr.', 'prof.'),
          @fulltime,
          @startdate,
          '+48' + cast(@phone AS VARCHAR)
        )
      END
  END
GO
