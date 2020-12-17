## Overview
The deployments in this directory were designed for a cluster of 18 workers running Kubernetes 1.19. The [accompanying repository with Ansible playbooks](https://github.com/torgeirl/kubernetes-playbooks) can be used to build a suitable test cluster.

### Allocatable and reserved resources
A worker node with 2 CPUs and 4 GB RAM is listed will the following resources allocatable for pods:
  - 1.9 CPU (95%)
  - 4022 MB (97.5%)

These pods will share resources with the Kubernetes system services running on the worker node:
  - Kubelet agent
  - network proxy (`kube-proxy`)
  - Docker (container runtime)
  - Flannel (container subnet)

Flannel requests 100m CPU (5%) and 50Mi RAM (1%) as part of its deployment configuration. Reserving compute resources for the other system services has to be [set during cluster initialization](https://v1-19.docs.kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/). 

Boreas has options to reserve CPU and RAM for the system services. To ensure comparable test results vs Kubernetes' default scheduler both these values needs to be set to `0` in `src/settings.ini`.

## Tests
  - Test0: deployment with 72 pods that request 100% CPU and 99% RAM of the cluster's total capacity, to verify that both the default scheduler and Boreas are capible to fill the cluster completely.

  - Test1: 

## Running the evaluation tests
Run the tests as regular Kubernetes deployments:
  - `$ kubectl create -f deployments/2021-paper/test1-boreas`

List all pods sorted by worker node:
  - `$ kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName --sort-by="{.spec.nodeName}"` 
