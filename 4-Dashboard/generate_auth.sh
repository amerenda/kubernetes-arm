#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo "Run the script with the required auth user and namespace for the secret: ${0} [user] [namespace]"
    exit 0
fi
printf "${1}:`openssl passwd -apr1`\n" >> _auth.tmp
kubectl delete secret -n ${2} ingress-auth
kubectl create secret generic dashboard-auth --from-file=_auth.tmp -n ${2}
rm _auth.tmp
