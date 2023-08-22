-include Makefile.local

all: 

include mk/pre_include.mk
include .devcontainer/rules.mk

HELP_MSG += \tcheck-hadolint\t\t check Dockerfile with hadolint linter\n

help:
	@printf "Usage: make [target]                               \n";
	@printf "                                                   \n";
	@printf "Available targets:                                 \n";
	@printf "                                                   \n";
	@printf "\thelp                     Show this help message  \n";
	@printf "$(HELP_MSG)                                        \n";
	@printf "                                                   \n";

check: check-hadolint check-yamllint

check-hadolint:
	@hadolint .devcontainer/node.Dockerfile

check-ymllint:
	@yamllint -c .yamllint .

clean:
	$(RM) -rf build
