#!/usr/bin/env bash
kubectl cluster-info > /dev/null 2>&1
if [ $? -eq 1 ]
then
  echo "kubectl was unable to reach your Kubernetes cluster. Make sure that" \
       "you have selected one using the 'gcloud container' commands."
  exit 1
fi


kubectl delete configmap drone-config --namespace=drone 2> /dev/null
kubectl delete secrets drone-secrets --namespace=drone 2> /dev/null
kubectl delete service drone-service --namespace=drone 2> /dev/null
kubectl delete deployment drone-server --namespace=drone 2> /dev/null
kubectl delete deployment drone-agent --namespace=drone 2> /dev/null
kubectl delete ingress drone-ingress --namespace=drone 2> /dev/null
