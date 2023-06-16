# ml-stuffing
ML-stuffing CUDA scripts for Ubuntu-server with PyTorch, Apex, Deepspeed

## Usage
After `sh ./install-nvidia-docker.sh` done, please run `reboot`

When everything established you may build and run image with:
```
# set DOCKER_BUILDKIT=1 as environment variable to boost docker
docker image build --tag 'your-image-name'
# you'll get path to your image, so:
docker container run --gpus all path/to/your-image-name <blah-blah>
```
Or use make to build and run with Jupyter Notebook
```
make build
make jupyter
```

Also minimal test, if cuda works, looks like this:
```
docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
```