Drupal K8s Role
=========

This role configures an instance of Drupal inside of a Kubernetes cluster and namespace.

Requirements
------------

Requires the `openshift` Python library to interact with Kubernetes: `pip install openshift`.

Role Variables
--------------

TODO.

Dependencies
------------

N/A

Example Playbook
----------------

```
---
- hosts: k8s
  roles:
    - drupal
```

License
-------

BSD

Author Information
------------------

[Jeff Geerling](https://www.jeffgeerling.com).
