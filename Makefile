TIMEOUT=120

build:
	docker build -t riak .

start: build
	docker-compose up -t $(TIMEOUT) -d
	docker-compose scale -t $(TIMEOUT) riak=5

stop:
	docker-compose stop -t $(TIMEOUT)

clean: stop
	docker-compose rm -fv
