#!/bin/bash
kubectl drain rpi3-0 --delete-local-data --force --ignore-daemonsets
kubectl drain rpi3-1 --delete-local-data --force --ignore-daemonsets
kubectl drain rpi3-2 --delete-local-data --force --ignore-daemonsets
kubectl drain rpi3-3 --delete-local-data --force --ignore-daemonsets
kubectl delete node rpi3-0
kubectl delete node rpi3-1
kubectl delete node rpi3-2
kubectl delete node rpi3-3

sudo kubeadm reset


