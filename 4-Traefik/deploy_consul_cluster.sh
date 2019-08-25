#!/bin/bash

helm install --name consul-traefik --namespace kube-system stable/consul --set ImageTag="1.5.3"
