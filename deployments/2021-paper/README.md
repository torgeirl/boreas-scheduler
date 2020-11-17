## Overview
The deployments in this directory were used to evaluate [the second release of the Boreas scheduler](https://github.com/boreas/boreas-scheduler/blob/master/CHANGELOG.md) as part of the research paper *Boreas – A Service Scheduler for Optimal Kubernetes Deployment*. The tests were designed for a cluster of 19 workers running Kubernetes 1.17.

The [accompanying repository with Ansible playbooks](https://github.com/torgeirl/kubernetes-playbooks) can be used to build a suitable test cluster.

## Running the evaluation tests
Run the tests as regular Kubernetes deployments:
  - `$ kubectl create -f deployments/2021-paper/test1-boreas`

List all pods sorted by worker node:
  - `$ kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName --sort-by="{.spec.nodeName}"` 
