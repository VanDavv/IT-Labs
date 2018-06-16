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
    desc TEXT NOT NULL,
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
    gross: FLOAT,
    contracor: TEXT,
    nip TEXT,
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'slot' AND xtype = 'U'
)

  CREATE TABLE slot (
    id    INT  NOT NULL PRIMARY KEY ,
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
    id    INT  NOT NULL PRIMARY KEY ,
    start_date DATE,
    end_date DATE,
    slot     BIGINT NOT NULL FOREIGN KEY REFERENCES slot(id) ,
    doctor     BIGINT NOT NULL FOREIGN KEY REFERENCES doctor (pesel) ,
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
    desc TEXT NOT NULL,
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
    invoice      BIGINT NOT NULL FOREIGN KEY REFERENCES invoice (id),
    recorder      BIGINT NOT NULL FOREIGN KEY REFERENCES registerer (pesel),
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'salary' AND xtype = 'U'
)

  CREATE TABLE salary (
    id         INT IDENTITY (1, 1) PRIMARY KEY,
    doctor     BIGINT NOT NULL FOREIGN KEY REFERENCES doctor (pesel),
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
    diagnosis       INT NOT NULL FOREIGN KEY REFERENCES diagnosis (id),
    prescription       INT NOT NULL FOREIGN KEY REFERENCES perscription (id),
    staff           BIGINT NOT NULL FOREIGN KEY REFERENCES employee (pesel),
    admission_hours INT NOT NULL FOREIGN KEY REFERENCES office_hours (pesel),
    visit           INT NOT NULL FOREIGN KEY REFERENCES visit (id),
  )
GO
