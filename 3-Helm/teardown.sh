#!/usr/bin/env bash

kubectl delete -f rbac-config.yaml

helm del --purge tiller
