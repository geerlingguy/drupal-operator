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
       # The container image to use for the Drupal deployment.
       drupal_image: 'drupal:8.8-apache'

       # Set this to 'true' to use a single-pod database managed by this operator.
       manage_database: true
       database_image: mariadb:10
       database_pvc_size: 1Gi
       database_password: change-me
     ```

  2. Use `kubectl` to create the Drupal site in your cluster:

     ```
     kubectl apply -f my-drupal-site.yml
     ```

There are many other options you can provide in the `spec`, to control the deployment and how it integrates with external services (e.g. set `manage_database` to `false` and override the `database_` options to integrate with a separate database backend).

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

After it is built, test it on a local cluster:

  1. `minikube start`
  2. `kubectl apply -f deploy/drupal-operator.yaml`
  3. `kubectl apply -f deploy/crds/drupal_v1alpha1_drupal_cr.yaml`

If everything is deployed correctly, commit the updated version and push it up to GitHub, tagging a new repository release with the same tag as the Docker image.

### Testing

#### Testing in Docker (standalone)

    molecule test -s test-local

This environment is meant for headless testing (e.g. in a CI environment, or when making smaller changes which don't need to be verified through a web interface). It is difficult to test things like Drupal's front-end or connecting other applications on your local machine to services running inside the cluster, since it is inside a Docker container with no static IP address.

#### Testing in Minikube

    minikube start
    minikube addons enable ingress
    molecule test -s test-minikube

[Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) is a more full-featured test environment running inside a full VM on your computer, with an assigned IP address. This makes it easier to test things like NodePort services and Ingress from outside the Kubernetes cluster (e.g. in a browser on your computer).

Once the operator is deployed, you can visit the Drupal in your browser by following these steps:

  1. Make sure you have an entry like `IP_ADDRESS  example-drupal.test` in your `/etc/hosts` file. (Get the IP address with `minikube ip`.)
  2. Visit `http://example-drupal.test/` in your browser.

## Authors

This is a fork of the original [drupal-operator](https://github.com/thom8/drupal-operator/) by [Thom Toogood](https://github.com/thom8). We have long collaborated on Drupal DevOps-related projects and Thom's work is impeccable.

This fork is maintained by [Jeff Geerling](https://www.jeffgeerling.com), author of [Ansible for DevOps](https://www.ansiblefordevops.com) and [Ansible for Kubernetes](https://www.ansibleforkubernetes.com).
