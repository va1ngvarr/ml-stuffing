#!/bin/sh

sudo apt-get update && sudo apt-get install -y git python3 python3-pip python3-venv \
     ninja-build cmake clang-9 llvm-9 llvm-9-dev llvm-9-tools libaio-dev

[ -d "venv/" ] && echo Virtual environment is already created. Keep it
[ ! -d "venv/" ] && python3 -m venv venv/
. venv/bin/activate

export DS_BUILD_CPU_ADAM=1
export DS_BUILD_SPARSE_ATTN=1
export DS_BUILD_OPS=0

pip install --upgrade pip
pip install torch==1.9 triton==1.0.0 && pip install -r requirements.txt

git clone https://github.com/NVIDIA/apex && cd apex
pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings \
    "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./

PORT=5000
# iptables -A INPUT -p tcp --dport $(PORT) -j ACCEPT
# jupyter notebook --ip 0.0.0.0 --no-browser --port=$(PORT)
