## Overview
The deployments in this directory were used to evaluate [the initial release of the Boreas scheduler](https://github.com/boreas/boreas-scheduler/blob/master/CHANGELOG.md#v010-2019-10-25) as part of the thesis *[Boreas – Reducing Resource Usage Through Optimized Kubernetes Scheduling](https://www.duo.uio.no/handle/10852/73303?locale-attribute=en)*. The tests were designed for a cluster of six workers running Kubernetes 1.12.

The [accompanying repository with Ansible playbooks](https://github.com/torgeirl/kubernetes-playbooks) can be used to build a suitable test cluster. See the appendices of the thesis for details.

## Running the evaluation tests
Run the tests as regular Kubernetes deployments:
  - `$ kubectl create -f deployments/2019-thesis/verification-default`
