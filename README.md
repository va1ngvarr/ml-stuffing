# ml-stuffing
ML-stuffing scripts for Ubuntu-server

## Usage
After `sh ./install-nvidia-docker.sh` done, please run `reboot`
Then you man run `sh ./setup-python-venv.sh`

When everything established you may build and run image with:
```
# set DOCKER_BUILDKIT=1 as environment variable to boost docker
docker image build --tag 'your-image-name' 
docker container run your-image-name
```