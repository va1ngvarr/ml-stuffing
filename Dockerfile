FROM nvcr.io/nvidia/pytorch:23.03-py3

ENV DEBIAN_FRONTEND="noninteractive"

ARG PYTHONDONTWRITEBYTECODE=1
ARG PYTHONUNBUFFERED=1
ARG DS_BUILD_OPS=0
ARG TORCH_CUDA_ARCH_LIST=Turing

WORKDIR /tmp/
COPY requirements.txt .

RUN apt-get update && apt-get install -y tzdata \
    git ninja-build libaio-dev

RUN pip install --upgrade pip && pip install -r requirements.txt
RUN git clone transformers && cd transformers && pip install ./ && cd .
RUN git clone https://github.com/NVIDIA/apex && cd apex \
    && pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation \
    --global-option="--cpp_ext" --global-option="--cuda_ext" ./

WORKDIR /app
 
CMD jupyter notebook --ip 0.0.0.0 --no-browser --allow-root
