#!/usr/bin/env bash
kubectl delete -f https://raw.githubusercontent.com/google/metallb/master/manifests/metallb.yaml

kubectl delete -f metallb-conf.yaml
