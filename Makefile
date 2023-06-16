PORT=8888

# Your app root in the container.
APP_DIR=/app

# The docker image to launch
APP_NAME=cudaenv
APP_TAG=$(APP_NAME):latest

build:
	docker image build \
		--tag '$(APP_NAME)' .

jupyter:
	docker container run \
		--gpus all -it \
		-p $(PORT):$(PORT) \
		-v $(PWD)/notebooks/:$(APP_DIR)/notebooks/ \
		-v $(PWD)/data:/data \
		$(APP_TAG) \
		jupyter notebook --ip 0.0.0.0 --port $(PORT) \
		--no-browser