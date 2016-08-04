TEMPLATE_NAME ?= janus

run: image
	@docker run -it -p 8089:8089 -p 6000:6000/udp $(TEMPLATE_NAME)

shell: image
	@docker run -it -p 8089:8089 -p 6000:6000/udp $(TEMPLATE_NAME) /bin/bash

image:
	@docker build -t $(TEMPLATE_NAME) .
