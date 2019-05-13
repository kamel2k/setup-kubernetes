#!/bin/bash
	
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
	
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
kubectl apply -f https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

kubectl get node
kubectl describe node k8s-master
kubectl get pods --all-namespaces
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl describe node k8s-master | grep -i taint
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

echo "****************** to be executed on worker ********************************"
echo "****************************************************************************"

echo "kubeadm join \\
--token $(sudo kubeadm token list | grep kubeadm | awk '{ print $1 }')  \\
  172.42.42.10:6443 \\
--discovery-token-ca-cert-hash \\
sha256:$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')"

