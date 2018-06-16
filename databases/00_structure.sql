USE master
GO

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
    WHERE name = 'employee_type' AND xtype = 'U'
)

  CREATE TABLE employee_type (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    profession TEXT NOT NULL,
    specialization TEXT NOT NULL,
    descr TEXT NOT NULL,
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'employee' AND xtype = 'U'
)
  CREATE TABLE employee (
    pesel                BIGINT PRIMARY KEY,
    name                 TEXT NOT NULL,
    degree               TEXT,
    fulltime             BIT,
    started_working_date DATE,
    phone                TEXT,
    type                 INT FOREIGN KEY REFERENCES employee_type (id),
  )
GO


IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'patient' AND xtype = 'U'
)

  CREATE TABLE patient (
    pesel             BIGINT PRIMARY KEY,
    name              TEXT NOT NULL,
    address           TEXT,
    phone             TEXT,
    major_diseases    TEXT,
    const_medications TEXT
  )
GO


IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'invoice' AND xtype = 'U'
)

  CREATE TABLE invoice (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    start_date DATE,
    number TEXT,
    netto FLOAT,
    tax FLOAT,
    gross FLOAT,
    contractor TEXT,
    nip TEXT,
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'slot' AND xtype = 'U'
)

  CREATE TABLE slot (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    day_num    INT  NOT NULL,
    start_hour TIME NOT NULL,
    end_hour   TIME NOT NULL
  )
GO


IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'office_hours' AND xtype = 'U'
)

  CREATE TABLE office_hours (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    day_num INT,
    start_date TIME,
    end_date TIME,
    employee     BIGINT NOT NULL FOREIGN KEY REFERENCES employee (pesel) ,
  )
GO

IF NOT exists (
    SELECT *
    FROM sysobjects
    WHERE name = 'office_hours_m2m' AND xtype = 'U'
)

CREATE TABLE office_hours_m2m (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    slot INT NOT NULL FOREIGN KEY REFERENCES slot(id),
    office_hours INT NOT NULL FOREIGN KEY REFERENCES office_hours(id)
)

GO


IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'registerer' AND xtype = 'U'
)

  CREATE TABLE registerer (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    name TEXT NOT NULL,
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'diagnosis' AND xtype = 'U'
)

  CREATE TABLE diagnosis (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    name TEXT NOT NULL,
    icd10 TEXT NOT NULL,
    descr TEXT NOT NULL,
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'medicine' AND xtype = 'U'
)

CREATE TABLE medicine (
    id          INT IDENTITY (1, 1) PRIMARY KEY,
    int_name      TEXT,
    detail_name        TEXT,
    dose        TEXT
)
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'prescription' AND xtype = 'U'
)

  CREATE TABLE prescription (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    prescription_id TEXT NOT NULL,
    medicine     INT NOT NULL FOREIGN KEY REFERENCES medicine (id),
    additionals TEXT NOT NULL,
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'visit' AND xtype = 'U'
)

CREATE TABLE visit (
    id          INT IDENTITY (1, 1) PRIMARY KEY,
    date        DATE,
    patient     BIGINT NOT NULL FOREIGN KEY REFERENCES patient (pesel),
    invoice      INT NOT NULL FOREIGN KEY REFERENCES invoice (id),
    recorder      INT NOT NULL FOREIGN KEY REFERENCES registerer (id),
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'salary' AND xtype = 'U'
)

  CREATE TABLE salary (
    id         INT IDENTITY (1, 1) PRIMARY KEY,
    employee     BIGINT NOT NULL FOREIGN KEY REFERENCES employee (pesel),
    start_date DATE,
    active     BIT,
    netto      FLOAT NOT NULL,
    vat_payer  BIT
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'examination' AND xtype = 'U'
)

CREATE TABLE examination (
    id          INT IDENTITY (1, 1) PRIMARY KEY,
    name        TEXT,
    value       INT
)
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'office' AND xtype = 'U'
)

CREATE TABLE office (
    id          INT IDENTITY (1, 1) PRIMARY KEY,
    number      TEXT,
    name        TEXT
)
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'examination_on_visit' AND xtype = 'U'
)

CREATE TABLE examination_on_visit (
    id              INT IDENTITY (1, 1) PRIMARY KEY,
    date            DATE,
    exam            INT NOT NULL FOREIGN KEY REFERENCES examination (id),
    diagnosis       INT FOREIGN KEY REFERENCES diagnosis (id),
    prescription    INT FOREIGN KEY REFERENCES prescription (id),
    staff           BIGINT NOT NULL FOREIGN KEY REFERENCES employee (pesel),
    admission_hours INT NOT NULL FOREIGN KEY REFERENCES office_hours (id),
    visit           INT NOT NULL FOREIGN KEY REFERENCES visit (id),
    office          INT NOT NULL FOREIGN KEY REFERENCES office (id)
  )
GO
