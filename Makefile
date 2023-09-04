-include Makefile.local
include .devcontainer/rules.mk

# ============================================================================= #
define DEPLOY_HELP_INFO
  deploy 
    deploy build sources to s3 bucket
endef
export DEPLOY_HELP_INFO

deploy:
	@aws s3 sync build s3://docs.devops.coachcrew.tech-public --delete

# ============================================================================= #
define CHECK_HELP_INFO
  check 
    run hadolint and yamllint
endef
export CHECK_HELP_INFO

check: check-hadolint check-yamllint

check-hadolint:
	@hadolint .devcontainer/node.Dockerfile
	@hadolint .devcontainer/deploy.Dockerfile

check-ymllint:
	@yamllint -c .yamllint .

clean:
	$(RM) -rf build

help:
	@echo "Usage: make [target] [VARIABLE=value]\n"
	@echo "$$BUILD_IMAGE_HELP_INFO\n"
	@echo "$$BUILD_DEPLOY_IMAGE_HELP_INFO\n"
	@echo "$$RUN_BUILD_HELP_INFO\n"
	@echo "$$DEPLOY_HELP_INFO\n"
	@echo "$$CLEAN_IMAGE_HELP_INFO\n"
	@echo "$$CHECK_HELP_INFO\n"
