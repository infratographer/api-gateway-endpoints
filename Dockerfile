FROM ghcr.io/infratographer/porton/porton@sha256:c4dddfad28aef9f3b3097cdadd9769cf90e1921a38b1a820b12ef7d33253f58c

USER root

# Install the configuration file in the expected path
COPY krakendcfg/krakend.tmpl /etc/krakend-src/config/krakend.tmpl

RUN chown -R 1000:1000 /etc/krakend-src/config/krakend.tmpl

USER 1000:1000

# required flexible configuration to enable yaml
ENV FC_OUT=/tmp/krakend.yml

ENTRYPOINT [ "/usr/bin/krakend" ]
CMD [ "run", "-c", "/etc/krakend-src/config/krakend.tmpl" ]
