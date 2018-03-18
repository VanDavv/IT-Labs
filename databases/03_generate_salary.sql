USE clinic
GO

IF NOT EXISTS(
    SELECT *
    FROM sys.objects
    WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('generate_salary')
)
  EXEC ('CREATE PROCEDURE generate_salary() AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE generate_salary()
AS
  BEGIN
    DECLARE @startdate DATE
    DECLARE @vat_payer INT
    DECLARE @netto FLOAT
    DECLARE @doctor BIGINT
    DECLARE cur CURSOR LOCAL FOR
      SELECT pesel from doctor order by newid()

    FETCH NEXT FROM cur INTO @doctor

    WHILE @@FETCH_STATUS = 0
      BEGIN
        SET @startdate = dateadd(DAY, (abs(CHECKSUM(newid())) % 3650) * -1, getdate())
        SET @vat_payer = ABS(CHECKSUM(NewId())) % 2
        SET @netto = (ABS(CHECKSUM(NewId())) % 500 + 1) / 10.0
        INSERT INTO salary(doctor, start_date, active, netto, vat_payer) VALUES (
          @doctor,
          @startdate,
          1,
          @netto,
          @vat_payer
        )
        FETCH NEXT FROM cur INTO @doctor
      END
    CLOSE cur
    DEALLOCATE cur
  END
GO
