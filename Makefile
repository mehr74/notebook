-include Makefile.local

all: 

include mk/pre_include.mk
include .devcontainer/rules.mk

HELP_MSG += \tcheck-hadolint\t\t check Dockerfile with hadolint linter\n


check: check-hadolint check-yamllint

check-hadolint:
	@hadolint .devcontainer/node.Dockerfile

check-ymllint:
	@yamllint -c .yamllint .

clean:
	$(RM) -rf build

help:
	@echo "Usage: make [target] [VARIABLE=value]\n"
	@echo "$$BUILD_IMAGE_HELP_INFO\n"
	@echo "$$BUILD_DEPLOY_IMAGE_HELP_INFO\n"
	@echo "$$RUN_BUILD_HELP_INFO\n"
