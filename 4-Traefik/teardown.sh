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


helm del --purge consul-traefik

sleep 20


# Deploy Traefik RBAC
kctl delete -f traefik-rbac.yaml
kctl delete -f internal-traefik-statefulset.yaml
kctl delete -f internal-traefik-service.yaml
kctl delete -f internal-traefik-consul-ingress.yaml

# Deploy internal Traefik config and service
kctl delete -f internal-traefik-configmap.yaml

# Deploy external Traefik config and service
kctl delete -f external-traefik-configmap.yaml
kctl delete -f external-traefik-statefulset.yaml
kctl delete -f external-traefik-service.yaml
