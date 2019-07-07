#!/usr/bin/env bash

if [ -z "${KUBECONFIG}" ]; then
    export KUBECONFIG=~/.kube/config
fi

# CAUTION - setting NAMESPACE will deploy most components to the given namespace
# however some are hardcoded to 'monitoring'. Only use if you have reviewed all manifests.

if [ -z "${NAMESPACE}" ]; then
    NAMESPACE=kube-system
fi

kctl() {
    kubectl --namespace "$NAMESPACE" "$@"
}

if ! [ -x "$(command -v helm)" ]; then
  echo 'Error: helm is not installed. It is required to deploy the Consul cluster.' >&2
  exit 1
fi

./deploy_consul_cluster.sh

echo "waiting 1 minute for consul to deploy..."
sleep 60
echo "deploying traefik..."


# Deploy Traefik RBAC
kctl apply -f traefik-rbac.yaml

# Deploy internal Traefik config 
kctl apply -f internal-traefik-configmap.yaml

# Deploy 
kctl apply -f internal-traefik-statefulset.yaml
kctl apply -f internal-traefik-service.yaml
kctl apply -f internal-traefik-consul-ingress.yaml


# Deploy external Traefik config and service
kctl apply -f external-traefik-configmap.yaml
kctl apply -f external-traefik-statefulset.yaml
kctl apply -f external-traefik-service.yaml
