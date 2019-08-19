#!/bin/bash
# Delete and recreate ingress resources on a given namespace
# ./refresh-ing.sh <namespace>
set -e
NAMESPACE=$1
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
echo "Refreshing ingress on namespace $NAMESPACE.."

# check namespace exits
kubectl get namespaces $NAMESPACE

# backup
kubectl get -o yaml --namespace $NAMESPACE ingresses.extensions > $NAMESPACE--$TIMESTAMP.yaml

# delete
kubectl -n $NAMESPACE delete ingress --all

# restore
kubectl -n $NAMESPACE apply -f $NAMESPACE--$TIMESTAMP.yaml


echo ""
# echo "Listing resources:"
# echo "Orders:"
# kubectl -n $NAMESPACE get orders
# echo "Challenges:"
# kubectl -n $NAMESPACE get challenges
echo "Certificates:"
kubectl -n $NAMESPACE get certificates
# echo "Secrets:"
# kubectl -n $NAMESPACE get secrets
# echo "Ingresses:"
# kubectl -n $NAMESPACE get ing
echo ""

echo "Done. If all looks good you can remove the backup file: $NAMESPACE--$TIMESTAMP.yaml"