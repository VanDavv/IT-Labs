#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S $DB_HOST,$DB_PORT -U sa -P TNTRocks! -i 00_structure.sql
# /opt/mssql-tools/bin/sqlcmd -S $DB_HOST,$DB_PORT -U sa -P TNTRocks! -i 01_generate_specialization.sql
# /opt/mssql-tools/bin/sqlcmd -S $DB_HOST,$DB_PORT -U sa -P TNTRocks! -i 02_generate_doctors.sql
# /opt/mssql-tools/bin/sqlcmd -S $DB_HOST,$DB_PORT -U sa -P TNTRocks! -i 03_generate_office_hours.sql
# /opt/mssql-tools/bin/sqlcmd -S $DB_HOST,$DB_PORT -U sa -P TNTRocks! -i 03_generate_patients.sql
# /opt/mssql-tools/bin/sqlcmd -S $DB_HOST,$DB_PORT -U sa -P TNTRocks! -i 03_generate_salary.sql
# /opt/mssql-tools/bin/sqlcmd -S $DB_HOST,$DB_PORT -U sa -P TNTRocks! -i 04_generate_visits.sql
# /opt/mssql-tools/bin/sqlcmd -S $DB_HOST,$DB_PORT -U sa -P TNTRocks! -i XX_execute.sql

sleep infinity
