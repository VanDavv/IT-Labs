build:
	docker build -t zut/databases .
run:
	docker run -d --name zut-databases zut/databases
exec:
	docker exec -it zut-databases bash
logs:
	docker logs zut-databases
clean:
	-docker kill zut-databases
	-docker rm zut-databases
