#!/bin/bash
# install full anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
apt update
apt install sudo -y
sudo sh Anaconda3-2019.07-Linux-x86_64.sh

# Source newly created conda command
source /root/anaconda3/etc/profile.d/conda.sh

# Create virtual environment 'my_env'
conda create -n my_env python=3.6 -y
conda activate my_env

# Install Jupyter plugin and general Python packages
conda install -y nb_conda # to see my_env inside jupyter lab/notebook
conda install -y matplotlib
conda install -y scipy

python -m ipykernel install --user --name myenv --display-name "Python (myenv)"

#Install TensorFlow-gpu 1.14 and PyTorch 
conda uninstall tensorflow
conda install -y -n my_env tensorflow-gpu=1.14.0 # install tensorflow 1.14, which is tested with cuda 10
conda install -y -n my_env pytorch=1.3.1 torchvision=0.4.2 cudatoolkit=10.1 -c pytorch

# Git details
git config --global user.email "your@email.com"

# Start Jupyter Lab server
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root &
