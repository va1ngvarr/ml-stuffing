#!/bin/sh

sudo apt-get update && sudo apt-get install -y git python3 python3-pip python3-venv \
     ninja-build cmake clang-9 llvm-9 llvm-9-dev llvm-9-tools libaio-dev

[ -d "venv/" ] && echo Virtual environment is already created. Keep it
[ ! -d "venv/" ] && python3 -m venv venv/
. venv/bin/activate

# CUDA 11.1
# pip install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html

# CUDA 10.2
# pip install torch==1.8.1+cu102 torchvision==0.9.1+cu102 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html

# CUDA 10.1
# pip install torch==1.8.1+cu101 torchvision==0.9.1+cu101 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html

pip install torch==1.8.2 \
    torchvision==0.9.2 torchaudio==0.8.2 triton==1.0.0 \
    --extra-index-url https://download.pytorch.org/whl/lts/1.8/cu111

pip install -r requirements.txt

git clone https://github.com/NVIDIA/apex && cd apex
pip install -v --disable-pip-version-check \
    --no-cache-dir --no-build-isolation --config-settings \
    "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./
rm -rf apex


# PORT=5000
# iptables -A INPUT -p tcp --dport $(PORT) -j ACCEPT
# jupyter notebook --ip 0.0.0.0 --no-browser --port=$(PORT)
