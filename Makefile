TIMEOUT=60

help:
	@echo ""
	@echo "  make start	Start Riak cluster and HAproxy"
	@echo "  make stop	Stop Riak cluster and HAproxy"
	@echo "  make build	Build containers"
	@echo "  make clean	Shutdown and remove containers"
	@echo ""

build: build-riak build-haproxy

build-riak:
	docker build -t riak --rm riak

build-haproxy:
	docker build -t riak-haproxy --rm haproxy

run: build
	docker-compose up -t $(TIMEOUT) -d
	docker-compose scale -t $(TIMEOUT) haproxy=1 riak=5

show: run
	@echo ""
	@echo "Connect to Riak:"
	@echo "  Protobuf: `docker-machine ip`:8087"
	@echo "  HTTP:     `docker-machine ip`:8098"
	@echo ""

start: show

stop:
	docker-compose stop -t $(TIMEOUT)

clean: stop
	docker-compose rm -fv

.PHONY: build build-riak build-haproxy run show start stop clean
