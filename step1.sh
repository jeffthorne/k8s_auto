#!/bin/bash

### Initial Setup

### configuraton
POSTGRES_PASSWORD=
AQUA_REGISTRY_USERNAME=
AQUA_REGISTRY_PASSWORD=
### end configuraton

kubectl create namespace aqua
kubectl create secret docker-registry aqua-registry --docker-server=registry.aquasec.com --docker-username=$AQUA_REGISTRY_USERNAME --docker-password=$AQUA_REGISTRY_PASSWORD --docker-email=no@email.com -n aqua
kubectl create secret generic aqua-db --from-literal=password=$POSTGRES_PASSWORD -n aqua

kubectl create -n aqua -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: aqua-sa
imagePullSecrets:
- name: aqua-registry
EOF

echo "sleeping 10 seconds before creating PV and PVCs" && sleep 10
kubectl apply -f step2.yaml -n aqua
echo "sleeping 60 seconds before deploying Postgres persistence layer" && sleep 60
kubectl apply -f step3.yaml -n aqua
echo "sleeping 60 seconds before deploying Aqua console and gateway" && sleep 60
kubectl apply -f step4.yaml -n aqua
echo $(kubectl get svc | grep aqua-web)