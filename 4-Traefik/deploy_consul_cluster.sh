#!/bin/bash
# Version 1.1.0 is needed because the consul manifest doesn't have the 1.0.0 image for ARM
helm install --name consul-traefik --namespace kube-system --set Image="amerenda/rpi-consul" --set ImageTag="latest" stable/consul 
