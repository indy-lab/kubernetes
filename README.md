# kubernetes
Files and guidelines on how to setup containers on the EPFL Kubernetes cluster

## Kubernetes administration: create, enter, delete, ...

#### Check status of all pods and services

`kubectl get all`

#### Create pod/service

Navigate to the folder where the yaml files for your configurations are on your (local) machine.

`kubectl create -f pod-deep.yaml`

`kubectl create -f svc-deep.yaml`

#### Check Kubernetes launching progress

`kubectl describe pod`

#### Enter/exit command line of pod

`kubectl exec -it deep -- /bin/bash`

`exit`

#### Get external IP and port

`kubectl get pod deep -o yaml | grep hostIP`

Note that this only gives the ip address. The external port mapping can be found through `kubectl get all`

#### Delete pod/service

`kubectl delete pod deep`

`kubectl delete service deep`

#### Copy files from local machine to pod
`kubectl cp ~/Documents/file.txt deep:/data/`

#### Copy files and directories with progress bar

`rsync -r --progress <source> <target>`

## Pytorch pod commands

### Use install script
`sudo bash install_script.sh`

### Administration

#### Check GPU status

`nvidia-smi`

#### GPU clean memory
Replace `/dev/nvidia#` with the GPU number:  
`for i in $(sudo lsof /dev/nvidia1 | grep python  | awk '{print $2}' | sort -u); do kill -9 $i; done`  
source: https://forums.developer.nvidia.com/t/11-gb-of-gpu-ram-used-and-no-process-listed-by-nvidia-smi/44459/12

#### GPU clean memory (dirty)
kill all python processes (sleeping, but claiming GPU memory)

`pkill -9 python`

#### Kill process(es)

Replace `name` with part of the executed command (e.g. see (h)top):  
`ps aux | grep Reptile`  
Replace `id` with process id listed in the previous step
`kill -9 id`  

#### Check PyTorch GPU

`python`

`import torch`

`torch.cuda.get_device_name(0)`

#### Check TensorFlow GPU

`python`

`import tensorflow as tf`

```
with tf.Session() as sess:
    print(sess.list_devices())
```

#### Launch (test) webserver

`python -m http.server 8888`

#### Launch Jupyter Notebook

`jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root`

#### Launch Jupyter Lab

`jupyter lab --ip=0.0.0.0 --port=8888 --allow-root`

#### Launch VS Code Server (from the `code-server` folder)

`sudo sh code-server --port 8080 --host 0.0.0.0 --auth none`

#### Shut down VS Code Server/...

`pkill -f code-server`

[source: How to kill all processes with a given partial name? [closed]
](https://stackoverflow.com/questions/8987037/how-to-kill-all-processes-with-a-given-partial-name)

#### TensorBoard

##### Launching TensorBoard

`tensorboard --logdir=./runs  --port=8888`

##### Kill TensorBoard
`ps -ef|grep tensorboard`

`kill -9 <first/second pid>`
### Install software

#### Install code-server web IDE (MS VS Code)
See the [code-server GitHub page](https://github.com/cdr/code-server#releases)

#### Install matplotlib

`pip install matplotlib`

#### Install/Upgrade PyTorch version
0.4.1:

`pip install http://download.pytorch.org/whl/cu90/torch-0.4.1-cp36-cp36m-linux_x86_64.whl`

1.0.0 (has cuda 9.0.176 embedded):

`pip3 install https://download.pytorch.org/whl/cu90/torch-1.0.0-cp36-cp36m-linux_x86_64.whl`


#### Install CUDNN 7
Follow https://medium.com/@zhanwenchen/install-cuda-and-cudnn-for-tensorflow-gpu-on-ubuntu-79306e4ac04e

#### Install Tensorflow-gpu 1.8.0
`pip install tensorflow-gpu==1.8`

#### Install screen (& autocomplete)
`echo "defshell -bash" > ~/.screenrc`

`source ~/.screenrc`

## Kubernetes config files

## Conda
### Make virtual environment visible in Jupyter
`conda activate myenv`  
`python -m ipykernel install --user --name myenv --display-name "Python (myenv)"`
