#!/bin/bash

# Install docker
sudo apt-get update -y
# sudo apt-get upgrade -y
sudo apt-get install curl net-tools -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

# some tools
sudo apt-get install htop tmux openssh-server smartmontools python3-pip unzip auditd gcp ffmpeg parallel -y

# Rust language (this will block the script)
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install nvidia driver
sudo apt-get install linux-headers-$(uname -r)
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update -y && sudo apt-get -y install nvidia-driver-555 cuda
rm cuda-keyring_1.0-1_all.deb

# search driver version
# sudo apt-cache search nvidia-driver-*

# Install nvidia container toolkit
# distribution="ubuntu22.04" for pop_os_22_04
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update && sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

# Manually restart the system once the script has finished executing.
# How to Use:
#   To execute this script, input the following command
#   sudo bash ubuntu_init_setup.sh

