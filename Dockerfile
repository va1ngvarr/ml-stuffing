FROM nvidia/cuda:11.6.2-base-ubuntu20.04

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata
CMD python3 -c "import torch; print(torch.cuda.is_available())"