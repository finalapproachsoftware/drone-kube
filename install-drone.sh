#!/usr/bin/env bash
kubectl cluster-info > /dev/null 2>&1
if [ $? -eq 1 ]
then
  echo "kubectl was unable to reach your Kubernetes cluster. Make sure that" \
       "you have selected one using the 'gcloud container' commands."
  exit 1
fi

#create namespace
kubectl get namespace drone > /dev/null 2>&1
if [ $? -eq 1 ]
then
  echo "Could not find the drone namespae.  Createing it now..."
  kubectl create -f templates/namespace.yaml
fi

# Clear out any existing configmap. Fail silently if there are none to delete.
kubectl delete configmap drone-config --namespace=drone 2> /dev/null
if [ $? -eq 1 ]
then
  echo "Before continuing, make sure you've used the provided template to create a configmap.yaml for your environment"
  echo
  read -p "<Press enter once you've made your configmap file>"
fi
kubectl create -f configmap.yaml

# If secrets.yaml isn't present, we'll auto-generate the Drone secret and
# upload it via kubectl.
kubectl delete secrets drone-secrets --namespace=drone 2> /dev/null
if ! [ -f "secrets.yaml" ];
then
    echo "Before continuing, make sure you've used the provided template to create a secrets.yaml for your environment"
    echo
    read -p "<Press enter once you've made your secrets file>"
fi
kubectl create -f secrets.yaml

kubectl create -f templates/service.yaml 2> /dev/null
echo
echo "===== Drone Service ready ============================================"

kubectl delete deployment drone-server --namespace=drone 2> /dev/null
kubectl create -f templates/server.yaml
echo
echo "===== Drone Server installed ============================================"

kubectl delete deployment drone-agent --namespace=drone 2> /dev/null
kubectl create -f templates/agent.yaml
echo
echo "===== Drone Agent installed ============================================"


kubectl create -f templates/ingress.yaml 2> /dev/null
echo
echo "===== Drone Ingress LB ready ============================================"