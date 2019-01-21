# kubernetes
Files and guidelines on how to setup containers on the EPFL Kubernetes cluster

## Kubernetes administration: create, enter, delete, ...

#### Check status of all pods and services

`kubectl get all`

#### Create pod/service

Navigate to the folder where the yaml files for your configurations are on your (local) machine.

`kubectl create -f pod-pytorch-v2.yaml`

`kubectl create -f svc-pytorch-v2.yaml`

#### Enter/exit command line of pod

`kubectl exec -it pytorch-v2 -- /bin/bash`

`exit`

### Get external IP and port

`kubectl get pod pytorch-v2 -o yaml | grep hostIP`

Note that this only gives the ip address. The external port mapping can be found through `kubectl get all`

#### Delete pod/service

`kubectl delete pod pytorch-v2`

`kubectl delete service svc-pytorch-v2`

## Pytorch-v2 pod commands

#### Check GPU status

`nvidia-smi`

#### Check PyTorch GPU

`python`

`import torch`

`torch.cuda.get_device_name(0)`

#### Launch (test) webserver

`python -m http.server 8888`

#### Launch Jupyter Notebook

`jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root`

#### Launch Jupyter Lab

`jupyter lab --ip=0.0.0.0 --port=8888 --allow-root`

#### Install matplotlib

`pip install matplotlib`

## Kubernetes config files