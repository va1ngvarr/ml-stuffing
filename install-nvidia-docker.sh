#!/bin/sh

sudo apt-get update && sudo apt install curl

# Install latest driver that supports our nvidia card
sudo ubuntu-drivers autoinstall

# We'll need this variable a little bit later
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

# Get nvidia repos
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list \ 
    | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Install docker and nvidia cuda toolkit
sudo apt-get update
sudo apt-get install -y docker nvidia-docker2 nvidia-container-toolkit nvidia-container-toolkit-base

# Docker may be disabled by default, so we should enable it manually
sudo systemctl enable docker

echo ======== Nvidia and docker tools established =========
echo Do not forget reboot the system to load nvidia modules
