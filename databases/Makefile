all:
	docker cp 00_structure.sql mssql:/
	docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -i /00_structure.sql -U sa -P Secret123@
	docker cp fill_database.sql mssql:/
	docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -i /fill_database.sql -U sa -P Secret123@

exec:
	docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Secret123@

db:
	docker run --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Secret123@' -p 1433:1433 -d microsoft/mssql-server-linux:2017-CU7

db-clean:
	-docker kill mssql
	-docker rm -f mssql
