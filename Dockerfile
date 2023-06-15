FROM nvidia/cuda:11.6.2-base-ubuntu20.04

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata

COPY venv/ /home
RUN cd home && . venv/bin/activate && DS_BUILD_OPS=0 pip install deepspeed

CMD python3 -c "import torch; print(torch.cuda.is_available())"