FROM nvcr.io/nvidia/pytorch:23.03-py3

ENV DEBIAN_FRONTEND="noninteractive"

ARG PYTHONDONTWRITEBYTECODE=1
ARG PYTHONUNBUFFERED=1
ARG DS_BUILD_OPS=0
ARG TORCH_CUDA_ARCH_LIST=Turing

ARG PORT=5000

WORKDIR /tmp/
COPY requirements.txt .

RUN apt-get update && apt-get install -y tzdata \
    git ninja-build libaio-dev

RUN pip install --upgrade pip && pip install -r requirements.txt

RUN git clone https://github.com/NVIDIA/apex && cd apex \
    && pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation \
    --global-option="--cpp_ext" --global-option="--cuda_ext" ./
 
CMD python3 -c "import torch; print(torch.cuda.is_available())" \
    && iptables -A INPUT -p tcp --dport ${PORT} -j ACCEPT \
    && jupyter notebook --ip 0.0.0.0 --no-browser --port=${PORT}
