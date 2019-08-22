#!/bin/bash
# Foreach ingress resource in cluster, attempt to connect/curl to it. Report results.

INGS=($(kubectl get ing --all-namespaces | tail -n +2 | awk '{print $3}' | cut -d',' -f1))  # Array of all ingress records in the cluster

for i in "${INGS[@]}"
do
   : 
   # do whatever on $i
   echo "Checking $i.."
   curl -sL -w "HTTP Response: %{http_code}\\n" https://$i  -o /dev/null  # Test endpoint with curl, assuming HTTPS here
   echo ""
done