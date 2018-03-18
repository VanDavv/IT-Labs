#!/bin/bash

/opt/mssql-tools/bin/sqlcmd -S 10.2.0.222,11433 -U sa -P TNTRocks! -i 03_generate_patients.sql
