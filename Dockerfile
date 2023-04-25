FROM ghcr.io/infratographer/porton/porton@sha256:68c8a7f263782dd09903361ff73ca359ec8df8aee0523e58c6f63b6893bbb137

USER root

# Install the configuration file in the expected path
COPY krakend.tmpl /etc/krakend-src/config/krakend.tmpl

RUN chown -R 1000:1000 /etc/krakend-src/config/krakend.tmpl

USER 1000:1000

ENTRYPOINT [ "/usr/bin/krakend" ]
CMD [ "run", "-c", "/etc/krakend-src/config/krakend.tmpl" ]