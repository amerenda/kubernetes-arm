#!/usr/bin/env bash
kubectl apply -f https://raw.githubusercontent.com/google/metallb/master/manifests/metallb.yaml

kubectl apply -f metallb-conf.yaml
