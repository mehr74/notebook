# ============================================================================= #
# Version  v2.1.0                                                               #
# Date     2023.06.08                                                           #
# CoachCrew.tech                                                                #
# admin@CoachCrew.tech                                                          #
# ============================================================================= #

FROM node:20 AS builder

# Install build essentials ---------------------------------------------------- #
RUN apt-get update                             && \
    apt-get install -y --no-install-recommends    \
        sudo

WORKDIR /opt/app
COPY . /opt/app

# Install NPM packages required for docusaurus -------------------------------- #
RUN npm install

# Install Dockerfile linter --------------------------------------------------- #
RUN curl -LO https://github.com/hadolint/\
hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64 && \
    cp hadolint-Linux-x86_64 /usr/bin/hadolint           && \
    chmod 755 /usr/bin/hadolint


RUN chmod +x /opt/app/.devcontainer/develop-entrypoint.sh
ENTRYPOINT ["/opt/app/.devcontainer/develop-entrypoint.sh"]

FROM scratch AS installer

COPY --from=builder /opt/app/ /app

