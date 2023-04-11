GATEWAY_IMAGE=ghcr.io/infratographer/api-gateway-image
GATEWAY_IMAGE_TAG?=latest
KRAKEND_PORT?=8080
SETTINGS_ENV?=dev

# This is the default output path for the `aggregate` target.
# It uses `-` by default which means stdout.
DEBUG?=true

# Override the default docker run arguments. this is useful for running the
# commands as a non-root user.
LOCAL_RUN_ARGS?=--userns host -u $(shell id -u):$(shell id -g)

.PHONY: help
help: Makefile ## Print help
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | sed -e 's/:.*##/#/' | column -c 2 -t -s#

.PHONY: check-generate
check-generate:	## Run verification on endpoints
	@echo "Verifying the endpoints and config"
	@docker run \
		--rm -t --user root \
		-v $(PWD):/workdir \
		-v $(PWD)/krakendcfg:/etc/krakend/ \
		-e KRAKEND_PORT=${KRAKEND_PORT} \
		-e FC_ENABLE=1 \
		-e FC_SETTINGS=/etc/krakend/settings/${SETTINGS_ENV} \
		-e FC_PARTIALS=/etc/krakend/partials \
		-e FC_TEMPLATES=/etc/krakend/templates \
		-e FC_OUT=/workdir/krakend.yml \
		devopsfaith/krakend check -dtc krakend.tmpl

.PHONY: gateway-image
gateway-image: check-generate ## Generate the krakend configuration and build the image
	@echo "building API image..."
	@docker build --no-cache -t $(GATEWAY_IMAGE):$(GATEWAY_IMAGE_TAG) -f Dockerfile .
	@echo "endpoints image available in $(GATEWAY_IMAGE):$(GATEWAY_IMAGE_TAG)"

.PHONY: run-local
run-local: gateway-image ## Build and run local api gateway
	@echo starting api gateway
	@docker run --rm -p ${KRAKEND_PORT}:${KRAKEND_PORT} ghcr.io/infratographer/api-gateway-image
