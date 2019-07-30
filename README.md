# Drupal Operator for Kubernetes

[![Build Status](https://travis-ci.com/geerlingguy/drupal-operator.svg?branch=master)](https://travis-ci.com/geerlingguy/drupal-operator)

This is a Drupal Operator, which makes management of Drupal instances running inside Kuberenetes clusters easy. It was built with the [Operator SDK](https://github.com/operator-framework/operator-sdk) using [Ansible Operator](https://www.ansible.com/blog/ansible-operator).

## Usage

This Kubernetes Operator is meant to be deployed in your Kubernetes cluster(s) and can manage one or more Drupal instances in any namespace.

First you need to deploy Drupal Operator into your cluster:

    kubectl apply -f https://raw.githubusercontent.com/geerlingguy/drupal-operator/master/deploy/drupal-operator.yaml

Then you can create instances of Drupal in any namespace, for example:

  1. Create a file named `my-drupal-site.yml` with the following contents:

         ```
         ---
         apiVersion: drupal.drupal.org/v1alpha1
         kind: Drupal
         metadata:
           name: my-drupal-site
           namespace: default
         spec:
           drupal_image: 'drupal:8.7-apache'
           # You should generate your own hash salt, e.g. `Crypt::randomBytesBase64(55)`.
           drupal_hash_salt: 'provide hash_salt here'
           drupal_trusted_host_patterns: 'provide trusted_host_patterns here'
           files_pvc_size: 1Gi
           manage_database: true
           database_image: mariadb:10
           database_pvc_size: 1Gi
         ```

  2. Use `kubectl` to create the Drupal site in your cluster:

         ```
         kubectl apply -f my-drupal-site.yml
         ```

> You can also deploy `Drupal` applications into other namespaces by changing `metadata.namespace`, or deploy multiple `Drupal` instances into the same namespace by changing `metadata.name`.

## Development

### Release Process

There are a few moving parts to this project:

  1. The Docker image which powers Drupal Operator.
  2. The `drupal-operator.yaml` Kubernetes manifest file which initially deploys the Operator into a cluster.

Each of these must be appropriately built in preparation for a new tag:

#### Build a new release of the Operator for Docker Hub

Run the following command inside this directory:

    operator-sdk build geerlingguy/drupal-operator:0.0.1

Then push the generated image to Docker Hub:

    docker login -u geerlingguy
    docker push geerlingguy/drupal-operator:0.0.1

#### Build a new version of the `drupal-operator.yaml` file

Verify the `build/chain-operator-files.yml` playbook has the most recent version/tag of the Docker image, then run the playbook in the `build/` directory:

    ansible-playbook chain-operator-files.yml

After it is built, test it on a local cluster (e.g. `minikube start` then `kubectl apply -f deploy/drupal-operator.yaml`), then commit the updated version and push it up to GitHub, tagging a new repository release with the same tag as the Docker image.

### Testing

#### Local tests with Molecule and KIND

Ensure you have the testing dependencies installed (in addition to Docker):

    pip install docker molecule openshift jmespath

Run the local molecule test scenario:

    molecule test -s test-local

#### Local tests with minikube

TODO.

## Authors

This is a fork of the original [drupal-operator](https://github.com/thom8/drupal-operator/) by [Thom Toogood](https://github.com/thom8). We have long collaborated on Drupal DevOps-related projects and Thom's work is impeccable.

This fork is maintained by [Jeff Geerling](https://www.jeffgeerling.com), author of [Ansible for DevOps](https://www.ansiblefordevops.com) and [Ansible for Kubernetes](https://www.ansibleforkubernetes.com).
