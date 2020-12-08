#!/bin/bash
# install full anaconda
echo -e "\033[0;32mINSTALL SCRIPT: \033[0;33mStarting\033[0m"
if [ ! -e Anaconda3-2019.07-Linux-x86_64.sh ]; then
	echo -e "\033[0;31m Anaconda file not found. Downloading Anaconda 2019.07\033[0m"
	wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
fi
apt update
apt install sudo -y
sudo bash Anaconda3-2019.07-Linux-x86_64.sh -b -u

echo -e "\033[0;32mINSTALL SCRIPT: \033[0;33mAnaconda installed\033[0m"
# Source newly created conda command
source /root/anaconda3/etc/profile.d/conda.sh

# Create virtual environment 'my_env'
conda create -n my_env python=3.6 -y
conda activate my_env

echo -e "\033[0;32mINSTALL SCRIPT: \033[0;33mVirtual environment \033[1;37mmy_env \033[0;33mcreated\033[0m"

# Install Jupyter plugin and general Python packages
conda install -y -q nb_conda # to see my_env inside jupyter lab/notebook
conda install -y -q matplotlib
conda install -y -q scipy

echo -e "\033[0;32mINSTALL SCRIPT: \033[0;33mInstalled python packages with conda:\033[1;33m nb_conda, matplotlib, scipy\033[0m"

python -m ipykernel install --user --name myenv --display-name "Python (myenv)"

#Install TensorFlow-gpu 1.14 and PyTorch 
conda uninstall -q tensorflow
conda install -q -y -n my_env tensorflow-gpu=1.14.0 # install tensorflow 1.14, which is tested with cuda 10
conda install -q -y -n my_env pytorch=1.4.0 torchvision=0.5.0 cudatoolkit=10.1 -c pytorch

echo -e "\033[0;32mINSTALL SCRIPT: \033[0;33mInstalled python packages with conda:\033[1;33m pytorch 1.4.0, torchvision 0.5.0, tensorflow-GPU 1.14.0\033[0m"

# Git details
git config --global user.email "arnoutdev@gmail.com"

# Start Jupyter Lab server
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root &
