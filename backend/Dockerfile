# Find eligible builder and runner images on Docker Hub. We use Ubuntu/Debian instead of
# Alpine to avoid DNS resolution issues in production.
#
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=ubuntu
# https://hub.docker.com/_/ubuntu?tab=tags
#
#
# This file is based on these images:
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-20221004-slim - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.14.3-erlang-25.2-debian-bullseye-20221004-slim
#
ARG ELIXIR_VERSION=1.14.3
ARG OTP_VERSION=25.2
ARG DEBIAN_VERSION=bullseye-20221004-slim

ARG IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"


FROM ${IMAGE}

RUN apt-get update -y
RUN apt-get install -y postgresql-client
RUN apt-get install -y inotify-tools
RUN apt update

# Install Hex package manager.
RUN mix local.hex --force
RUN mix local.rebar --force

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY ./ /app

WORKDIR /app