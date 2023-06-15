FROM nvidia/cuda:11.6.2-base-ubuntu20.04 as build

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata \
    git ninja-build cmake clang-9 llvm-9 llvm-9-dev llvm-9-tools libaio-dev

COPY venv/ /
RUN . venv/bin/activate

RUN DS_BUILD_OPS=0 pip install deepspeed
RUN git clone https://github.com/NVIDIA/apex && cd apex \
    && pip install -v --disable-pip-version-check \
    --no-cache-dir --no-build-isolation --config-settings \
    "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./

FROM nvidia/cuda:11.6.2-base-ubuntu20.04 as production

COPY --from=build /venv /
CMD python3 -c "import torch; print(torch.cuda.is_available())"