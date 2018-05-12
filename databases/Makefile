build:
	docker build -t zut/databases .
run:
	docker run -d -e DB_HOST=mssql -e DB_PORT=1433 --name zut-databases zut/databases
exec:
	docker exec -it zut-databases /opt/mssql-tools/bin/sqlcmd -S 10.2.0.222,11433 -U sa -P TNTRocks!
logs:
	docker logs zut-databases
clean:
	-docker kill zut-databases
	-docker rm -f zut-databases

all: clean build run

db:
	docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=TNTRocks! -e MSSQL_PID=Express --name mssql -p 1433:1433 -d microsoft/mssql-server-linux:2017-CU4

db-clean:
	-docker kill mssql
	-docker rm -f mssql
