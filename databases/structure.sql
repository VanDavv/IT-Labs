IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'doctor' AND xtype = 'U'
)
  CREATE TABLE doctor (
    pesel                BIGINT PRIMARY KEY,
    name                 TEXT NOT NULL,
    spec                 INT FOREIGN KEY REFERENCES specialization (id),
    degree               TEXT,
    fulltime             BIT,
    started_working_date DATE,
    phone                TEXT
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'specialization' AND xtype = 'U'
)

  CREATE TABLE specialization (
    id   INT IDENTITY (1, 1) PRIMARY KEY,
    name TEXT NOT NULL
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
    family_doc        BIGINT FOREIGN KEY REFERENCES doctor (pesel),
    major_diseases    TEXT,
    const_medications TEXT
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'office_hours' AND xtype = 'U'
)

  CREATE TABLE office_hours (
    doctor     BIGINT FOREIGN KEY REFERENCES doctor (pesel) PRIMARY KEY,
    day_num    INT  NOT NULL,
    start_hour TIME NOT NULL,
    end_hour   TIME NOT NULL
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'visit' AND xtype = 'U'
)

  CREATE TABLE visit (
    id          INT IDENTITY (1, 1) PRIMARY KEY,
    doctor      BIGINT FOREIGN KEY REFERENCES doctor (pesel),
    patient     BIGINT FOREIGN KEY REFERENCES patient (pesel),
    date        DATE,
    time        TIME,
    nr          INT,
    symptoms    TEXT,
    diagnosis   TEXT,
    description TEXT,
    canceled    BIT
  )
GO

IF NOT exists(
    SELECT *
    FROM sysobjects
    WHERE name = 'salary' AND xtype = 'U'
)

  CREATE TABLE salary (
    id         INT IDENTITY (1, 1) PRIMARY KEY,
    doctor     BIGINT FOREIGN KEY REFERENCES doctor (pesel),
    start_date DATE,
    active     BIT,
    netto      FLOAT NOT NULL,
    vat_payer  BIT
  )
GO
