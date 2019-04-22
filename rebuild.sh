#!/usr/bin/env bash

# rebuild operator
operator-sdk build 8thom/drupal-operator:v0.0.1 
docker push 8thom/drupal-operator:v0.0.1

# redeploy operator
kubectl delete -f deploy/ 
kubectl apply -f deploy/

# redeploy crd
kubectl delete -f deploy/crds/drupal_v1alpha1_drupal_cr.yaml 
kubectl apply -f deploy/crds/drupal_v1alpha1_drupal_cr.yaml
