FROM ghcr.io/infratographer/krakend-endpoints-tool/krakend-endpoints-tool:latest as KET
FROM ghcr.io/infratographer/porton/porton@sha256:c4dddfad28aef9f3b3097cdadd9769cf90e1921a38b1a820b12ef7d33253f58c as PORTON

FROM mcr.microsoft.com/vscode/devcontainers/base:bullseye

# Set up krakend
RUN mkdir -p /opt/krakend
COPY --from=PORTON /usr/bin/krakend /usr/bin
COPY --from=PORTON /opt/krakend /opt/krakend

# copy endpoint tool
COPY --from=KET /krakend-endpoints-tool /usr/bin

# [Optional] Uncomment this section to install additional OS packages.
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
        bash-completion \
        uuid-runtime \
        musl-dev

# [Optional] Uncomment the next lines to use go get to install anything else you need
USER vscode

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

WORKDIR /workspace
