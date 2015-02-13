export DOCKER_CMD=docker

export CKAN_RELEASE=2.2.1-4
export VIRTUOSO_RELEASE=1.0.0
export NAME=eccenca/ckan-docker:${CKAN_RELEASE}
export TAG=eccenca/ckan-docker:latest

build: build-ckan

build-ckan:
	$(DOCKER_CMD) pull eccenca/baseimage:1.0.0
	$(DOCKER_CMD) build -t ${NAME} .
	$(DOCKER_CMD) tag -f $(NAME) ${TAG}

run:
	# start a container in the background
	$(DOCKER_CMD) run -d --name ckan-solr eccenca/ckan-solr:$(CKAN_RELEASE)
	$(DOCKER_CMD) run -d --name ckan-db eccenca/ckan-postgresql:$(CKAN_RELEASE)
	$(DOCKER_CMD) run -it --name ckan --link ckan-solr:solr --link ckan-db:db -p 80:80 -p 8080:8080  $(NAME) /bin/bash

run-ckan:
	# start a container in the background
	$(DOCKER_CMD) run -d --name ckan --link ckan-solr:solr --link ckan-db:db -p 80:80 -p 8080:8080 $(NAME)

run-ckan-bash:
	$(DOCKER_CMD) run -it --name ckan --link ckan-solr:solr --link ckan-db:db -p 80:80 -p 8080:8080 $(NAME) /bin/bash

exec:
	$(DOCKER_CMD) exec -it ckan /bin/bash

name:
	# test tag name generation
	@echo tag = $(TAG)
	@echo host = $(ECC_HOST)
	@echo cmd = $(DOCKER_CMD)

stop:
	# stop the default named container
	$(DOCKER_CMD) stop ckan-solr ckan-db ckan

start:
	# start the default named container
	$(DOCKER_CMD) start ckan-solr ckan-db ckan

start-ckan:
	$(DOCKER_CMD) start ckan

kill:
	# start the default named container
	$(DOCKER_CMD) kill ckan-solr ckan-db ckan

rm:
	# rm the default named container
	$(DOCKER_CMD) rm ckan-solr ckan-db ckan

rmi:
	# rm the default named image
	$(DOCKER_CMD) rmi eccenca/ckan-docker

save:
	$(DOCKER_CMD) save -o ${NAME}.tar ${NAME}

tag:
	$(DOCKER_CMD) tag -f ${NAME} ${TAG}

push: tag
	$(DOCKER_CMD) push ${NAME}
	$(DOCKER_CMD) push ${TAG}
