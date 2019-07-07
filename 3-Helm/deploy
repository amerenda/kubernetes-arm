#!/usr/bin/env bash
path_to_helm=$(which helm 2>/dev/null)
if [ -x "$path_to_helm" ]; then
    echo "helm installed on local system"
else
    echo "installing helm..."
    /usr/bin/env bash get_helm_client.sh
fi

if [ $? -ne 0 ]; then
    exit 1
fi

kubectl create -f rbac-config.yaml
helm init --service-account tiller --tiller-image jessestuart/tiller
# Patch Helm to land on an ARM node because of the used image
kubectl patch deployment tiller-deploy -n kube-system --patch '{"spec": {"template": {"spec": {"nodeSelector": {"beta.kubernetes.io/arch": "arm"}}}}}'
