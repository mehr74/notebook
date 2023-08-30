# ============================================================================= #
# Version  v2.1.0                                                               #
# Date     2023.06.08                                                           #
# CoachCrew.tech                                                                #
# admin@CoachCrew.tech                                                          #
# ============================================================================= #

.PHONY: help build-image run-develop run-test

CONTAINER_DIR      ?= .devcontainer
WORK_DIR           ?= $(shell pwd)/..
USERNAME           ?= testuser
USER_UID           ?= 1000
USER_GID           ?= 1000

IMAGE_NAME         ?= notebook
CONTAINER_NAME     ?= $(IMAGE_NAME)-$(USERNAME)-$(shell date +"%Y-%m-%d.%H-%M")
DOCKER_FILE        ?= $(CONTAINER_DIR)/node.Dockerfile
DEPLOY_DOCKER_FILE ?= $(CONTAINER_DIR)/deploy.Dockerfile
DOCKER_ENTRYPOINT  ?= $(CONTAINER_DIR)/develop-entrypoint.sh
SHARED_DIRS        ?= $(WORK_DIR)

define BUILD_IMAGE_HELP_INFO
  build-image
    build the image from the Dockerfile
endef
export BUILD_IMAGE_HELP_INFO

build-image: 
	@docker build --tag $(IMAGE_NAME):build --target builder     \
		--build-arg DOCKER_ENTRYPOINT=$(DOCKER_ENTRYPOINT) \
		--file $(DOCKER_FILE) .

define BUILD_DEPLOY_IMAGE_HELP_INFO
  build-deploy-image
    build the image from the Dockerfile
endef
export BUILD_DEPLOY_IMAGE_HELP_INFO

build-deploy-image: 
	@docker build --tag $(IMAGE_NAME):deploy --target deploy     \
		--build-arg DOCKER_ENTRYPOINT=$(DOCKER_ENTRYPOINT) \
		--file $(DEPLOY_DOCKER_FILE) .

# ============================================================================= #
define RUN_BUILD_HELP_INFO
  run-build	
    run the build command in a container from the build image
endef
export RUN_BUILD_HELP_INFO

run-build: build-image directories
	@docker run -it --rm                                     \
		--name $(CONTAINER_NAME)                         \
		--network host                                   \
		--env AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)     \
		--env AWS_SECRET_ACCESS_KEY=$(AWS_ACCESS_KEY_ID) \
		--env USERNAME=$(USERNAME)                       \
		--env USER_UID=$(USER_UID)                       \
		--env USER_GID=$(USER_GID)                       \
		--env PYTHON_REQ=$(PYTHON_REQ)                   \
		--env WORK_DIR=$(WORK_DIR)                       \
		$(foreach dir, $(SHARED_DIRS), -v $(dir):$(dir)) \
		$(IMAGE_NAME):build npm run build

clean-image:
	@docker rmi --force $(IMAGE_NAME)
	@rm -rf $(BUILD_IMAGE)
	@rm -rf $(DIRECTORIES)
