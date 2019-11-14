#!/bin/bash
# install full anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
sudo sh Anaconda3-2019.07-Linux-x86_64.sh

# Source newly created conda command
source /root/anaconda3/etc/profile.d/conda.sh

# Create virtual environment my_env
conda create -n my_env python=3.6
conda activate my_env

# Install packages
conda install -y nb_conda # to see my_env inside jupyter lab/notebook
conda install -y matplotlib
conda install -y scipy

python -m ipykernel install --user --name myenv --display-name "Python (myenv)"

#sudo apt install nvidia-410 # to install cuda 10.0 --> we have not control over driver, that's Kubernetes' decision
conda uninstall tensorflow
conda install -y -n my_env tensorflow-gpu==1.14.0 # install tensorflow 1.14, which is tested with cuda 10
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root &
