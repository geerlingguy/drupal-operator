# Drupal Operator for Kubernetes

[![Build Status](https://travis-ci.com/geerlingguy/drupal-operator.svg?branch=master)](https://travis-ci.com/geerlingguy/drupal-operator)

This is a Drupal Operator, which makes management of Drupal instances running inside Kuberenetes clusters easy. It was built with the [Operator SDK](https://github.com/operator-framework/operator-sdk) using [Ansible Operator](https://www.ansible.com/blog/ansible-operator).

## Usage

This Kubernetes Operator is meant to be deployed in your Kubernetes cluster(s) and can manage one or more Drupal instances in any namespace.

TODO.

## Development

TODO.

### Running tests locally with Molecule

Ensure you have the testing dependencies installed (in addition to Docker):

    pip install docker molecule openshift jmespath

Run the local molecule test scenario:

    molecule test -s test-local

## Authors

This is a fork of the original [drupal-operator](https://github.com/thom8/drupal-operator/) by [Thom Toogood](https://github.com/thom8). We have long collaborated on Drupal DevOps-related projects and Thom's work is impeccable.

This fork is maintained by [Jeff Geerling](https://www.jeffgeerling.com), author of [Ansible for DevOps](https://www.ansiblefordevops.com) and [Ansible for Kubernetes](https://www.ansibleforkubernetes.com).
