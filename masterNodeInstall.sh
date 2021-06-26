#!/bin/bash

apt update -y

apt install ansible docker.io -y

systemctl enable docker
systemctl start docker

apt install kubeadm kubelet kubectl -y
apt-mark hold kubeadm kubelet kubectl

cd /
swapoff –a

kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl get pods --all-namespaces
