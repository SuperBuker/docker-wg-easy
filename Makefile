REGISTRY_HOST ?= ghcr.io
REGISTRY_USERNAME ?= superbuker
IMAGE_NAME ?= wg-easy
IMAGE_TAG ?= latest


.PHONY: help all build push clean

help: ## Show this help
	@echo "Help"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36m%-20s\033[93m %s\033[0m\n", $$1, $$2}'

##
### Code compilation
all: build push clean

build: ## Build container image
	@docker build --tag "${REGISTRY_HOST}/${REGISTRY_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}" .

run:
	@docker run --rm -it "${REGISTRY_HOST}/${REGISTRY_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}" '/bin/sh'

push:  ## Push container image
	@docker push "${REGISTRY_HOST}/${REGISTRY_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"

clean:  ## Remove container image
	@docker rmi "${REGISTRY_HOST}/${REGISTRY_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"
