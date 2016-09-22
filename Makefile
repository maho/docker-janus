TEMPLATE_NAME ?= janus

run: image
	@docker run -it -p 8188:8188 -p 8189:8189 -p 6000:6000/udp -p 6001:6001/udp -p 6002:6002/udp $(TEMPLATE_NAME)

shell: image
	@docker run -it -p 8188:8188 -p 8189:8189 -p 6000:6000/udp -p 6001:6001/udp -p 6002:6002/udp $(TEMPLATE_NAME) /bin/bash

image:
	@docker build -t $(TEMPLATE_NAME) .
