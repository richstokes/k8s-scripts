#!/bin/bash
set -e
# For each namespace, delete all cert-manager resources (issuer,clusterissuer,certificates,orders,challenges,certificaterequests). Use with extreme caution!
# You'd potentially want to use this when uninstalling cert-manager
# As per https://docs.cert-manager.io/en/latest/tasks/uninstall/kubernetes.html

# Prompt
read -p "Are you sure you want to delete ALL cert-manager resources over ALL namespaces? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Vars
DATESTAMP=$(date "+%Y-%m-%d-%H-%M-%S")
NAMESPACES=($(kubectl get namespaces | tail -n +2 | awk '{print $1}'))  # Array of all namespaces in the cluster

# Take a backup
echo "Saving a backup to to cert-manager-backup_$DATESTAMP.yaml"
kubectl get -o yaml --all-namespaces issuer,clusterissuer,certificates,orders,challenges,certificaterequests > cert-manager-backup_$DATESTAMP.yaml

# Delete all the things
for i in "${NAMESPACES[@]}"
do
   : 
   echo "Deleting cert-manager resources from namespace: $i.."
   kubectl delete Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --namespace $i --all
done

echo "Checking all removed (should see nothing returned).."
kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces
echo ""
echo "Done."