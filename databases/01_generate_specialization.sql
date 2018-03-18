USE clinic
GO

IF NOT EXISTS(
    SELECT *
    FROM sys.objects
    WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('generate_specialization')
)
  EXEC ('CREATE PROCEDURE generate_specialization() AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE generate_specialization()
AS
  BEGIN
    DECLARE @i INT = 0

    WHILE @i < 10
      BEGIN
        SET @i = @i + 1

        INSERT INTO specialization VALUES (
          @i,
          choose(@i, 'Pediatra', 'Okulista', 'Laryngolog', 'Ginekolog', 'Pulmunolog', 'Kardiolog', 'Neonatolog', 'Neurolog', 'Endokrynolog', 'Psychiatra')
        )
      END
  END
GO
