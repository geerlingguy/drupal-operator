# Drupal Operator

![](https://tokei.rs/b1/github/thom8/drupal-operator)

This is a very early working POC for development of an drupal [Ansible operator](https://github.com/operator-framework/operator-sdk/blob/master/doc/proposals/ansible-operator.md), feedback is welcomed!

## Install Operator

`kubectl apply -f deploy/`

## Create a Drupal instance

Once the operator is installed in a namespace you can create `Drupal` resources.

```
apiVersion: drupal.org/v1alpha1
kind: Drupal
metadata:
  name: example-drupal
spec:
  version: 8.6
```

This will automatically trigger the operator to run the ansible playbook and deploy a new Drupal :)
