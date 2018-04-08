USE clinic
GO

SET IDENTITY_INSERT specialization ON
GO

generate_specialization
GO

SET IDENTITY_INSERT specialization OFF
GO

generate_doctors 10
GO

generate_office_hours
GO

generate_patients 100
GO

generate_salary
GO

generate_visits 1000
go
