# Variables
CONTAINER_NAME=netbootxyz
IMAGE=localbuild
PUID=1000
PGID=1000
TZ=Etc/UTC
PORT_RANGE=30000:30010
SUBFOLDER=/
CONFIG_PATH=./config
ASSETS_PATH=./assets
PORT_3000=3000:3000
PORT_69=69:69/udp
PORT_8180=8180:80

# Default target
all: run

# Run Docker container
run:
	docker run \
		--name $(CONTAINER_NAME) \
		-e PUID=$(PUID) \
		-e PGID=$(PGID) \
		-e TZ=$(TZ) \
		-e PORT_RANGE=$(PORT_RANGE) \
		-e SUBFOLDER=$(SUBFOLDER) \
		-v $(CONFIG_PATH):/config \
		-v $(ASSETS_PATH):/assets \
		-p $(PORT_3000) \
		-p $(PORT_69) \
		-p $(PORT_8180) \
		-v ${PWD}:/buildout \
		--restart unless-stopped \
		-d $(IMAGE)

# Stop Docker container
stop:
	docker stop $(CONTAINER_NAME)

# Remove Docker container
remove:
	docker rm $(CONTAINER_NAME)

# Build Docker image (if necessary)
build:
	docker build -t $(IMAGE) .

clean:
	docker rm --force netbootxyz

logs:
	docker logs -f netbootxyz

debug:
	docker run --rm -v ${PWD}:/buildout -ti localbuild bash
