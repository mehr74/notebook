# ============================================================================= #
# Version  v2.1.0                                                               #
# Date     2023.06.08                                                           #
# CoachCrew.tech                                                                #
# admin@CoachCrew.tech                                                          #
# ============================================================================= #
FROM node:20 AS builder

WORKDIR /opt/app
COPY . /opt/app

# Install NPM packages required for docusaurus -------------------------------- #
RUN npm install