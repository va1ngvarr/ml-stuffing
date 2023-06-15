#!/bin/sh

. venv/bin/activate

# 

pip install torch==1.8.2 \
    torchvision==0.9.2 torchaudio==0.8.2 triton==1.0.0 \
    --extra-index-url https://download.pytorch.org/whl/lts/1.8/cu111


# PORT=5000
# iptables -A INPUT -p tcp --dport $(PORT) -j ACCEPT
# jupyter notebook --ip 0.0.0.0 --no-browser --port=$(PORT)
