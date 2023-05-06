FROM ghcr.io/infratographer/porton/porton@sha256:51ef0249801409cb5604788e7bc801373ca040b3bf9c7f04258262483768786b

USER root

# Install the configuration file in the expected path
COPY krakendcfg/krakend.tmpl /etc/krakend-src/config/krakend.tmpl

RUN chown -R 1000:1000 /etc/krakend-src/config/krakend.tmpl

USER 1000:1000

# required flexible configuration to enable yaml
ENV FC_OUT=/tmp/krakend.yml

ENTRYPOINT [ "/usr/bin/krakend" ]
CMD [ "run", "-c", "/etc/krakend-src/config/krakend.tmpl" ]
