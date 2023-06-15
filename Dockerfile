FROM nvidia/cuda:11.6.2-runtime-ubuntu20.04 as build

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y tzdata \
    git ninja-build cmake clang-9 llvm-9 llvm-9-dev llvm-9-tools libaio-dev \
    python3 python3-pip python3-venv

COPY requirements.txt /
RUN python3 -m venv venv/ && . venv/bin/activate

ENV DS_BUILD_OPS=0
ENV TORCH_CUDA_ARCH_LIST=Turing
RUN pip install --upgrade pip && pip install -r requirements.txt \
    --extra-index-url https://download.pytorch.org/whl/lts/1.8/cu111 \
    && pip install deepspeed

FROM nvidia/cuda:11.6.2-base-ubuntu20.04 as production

COPY --from=build ./venv .
ENV PORT=5000
CMD . venv/bin/activate && python3 -c "import torch; print(torch.cuda.is_available())" \
    && iptables -A INPUT -p tcp --dport $(PORT) -j ACCEPT \
    && jupyter notebook --ip 0.0.0.0 --no-browser --port=$(PORT)

