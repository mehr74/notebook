# ============================================================================= #
# Version  v2.1.0                                                               #
# Date     2023.06.08                                                           #
# CoachCrew.tech                                                                #
# admin@CoachCrew.tech                                                          #
# ============================================================================= #
FROM ubuntu:18.04 AS deploy

RUN apt-get update -y && \
  apt-get install -y --no-install-recommends    \
    ca-certificates \
    curl \
    tar \
    unzip

WORKDIR /opt/aws
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o "awscliv2.zip" && \
  unzip awscliv2.zip  && \
  ./aws/install

USER 1000
WORKDIR /opt/github-action
ENV VERSION=2.308.0
RUN curl -o actions-runner-linux-x64-${VERSION}.tar.gz \
  -L https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz && \
  tar xzf ./actions-runner-linux-x64-${VERSION}.tar.gz

USER root
RUN ./bin/installdependencies.sh

USER 1000
