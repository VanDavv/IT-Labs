IF NOT exists(
    SELECT *
    FROM sys.databases
    WHERE name = 'clinic'
)
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
    specialization       INT,
    degree               TEXT,
    fulltime             BIT,
    started_working_date DATE,
    phone                TEXT
  )
GO
