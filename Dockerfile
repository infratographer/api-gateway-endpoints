FROM ghcr.io/infratographer/porton/porton@sha256:f11778e9aa318913d4e4690a1201a7670bac25e82dfc7f74a3b2e75dfeea8a72

USER root

# Install the configuration file in the expected path
COPY krakend.tmpl /etc/krakend-src/config/krakend.tmpl

RUN chown -R 1000:1000 /etc/krakend-src/config/krakend.tmpl

USER 1000:1000

ENTRYPOINT [ "/usr/bin/krakend" ]
CMD [ "run", "-c", "/etc/krakend-src/config/krakend.tmpl" ]