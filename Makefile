# I have no idea why, but this demo doesn't work when gstreamer sends to 127.0.0.1 or
# host.docker.internal - you need to check what is your ip and fill it here, or use
#  make JANUS_SERVER=<your_ip_address>
#
JANUS_SERVER?=fill_in

run-server:
	@if [ $(JANUS_SERVER) = fill_in ];then \
		 echo "ERROR: set JANUS_SERVER variable to your external ip, eg. make JANUS_SERVER=192.168.1.123";false; \
	else \
		true; \
	fi
	docker-compose up --build
	@echo "open brower at http://localhost:8000 port"
