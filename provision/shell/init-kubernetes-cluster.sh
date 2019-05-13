#!/bin/bash

# init kubernetes cluster
kubeadm init --apiserver-advertise-address=172.42.42.10 --apiserver-cert-extra-sans=172.42.42.10 --node-name k8s-master --pod-network-cidr 192.168.0.0/16



