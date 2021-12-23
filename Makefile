DEFAULT_FILE := -f ./docker-compose.yml
AWS_SERVICES  := dynamodb awscli

.PHONY: clean

up:
	docker-compose up

down:
	docker-compose down

updb:
	docker-compose up awscli dynamodb

test:
	docker-compose $(DEFAULT_FILE) -f ./app/docker-compose.ci.yml build $(AWS_SERVICES) app
	docker-compose $(DEFAULT_FILE) up --detach $(AWS_SERVICES)
	until [ "`docker ps | grep healthy | wc -l`"=="1" ]; do sleep 1; done;
	docker-compose $(DEFAULT_FILE) -f ./app/docker-compose.ci.yml run app
	docker-compose down

clean:
	rm -rf ./tmp