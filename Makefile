# Avoid 8888 if you run local notebooks on that!
PORT=8888

# Your app root in the container.
APP_DIR=/app

# The docker image to launch
APP_NAME=cudaenv
APP_TAG=docker.io/library/$(APP_NAME)

build:
	docker image build \
		--tag '$(APP_NAME)' .

jupyter:
	## Launch jupyter notebook from our container, mapping two folders
	##    Local          Container       Notes
	##    -----------------------------------------------------
	##    ./data      -> /data           Put data here!
	##    ./notebooks -> /notebooks      Find notebooks here!
	##    -----------------------------------------------------
    docker container run \
		--gpus all -it \
		-p $(PORT):$(PORT) \
		-v $(PWD)/notebooks/:$(APP_DIR)/notebooks/ \
		-v $(PWD)/data:/data \
		$(APP_TAG) \
		jupyter notebook --ip 0.0.0.0 --port $(PORT) \
		--no-browser --allow-root