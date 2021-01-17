## Overview
The deployments in this directory were designed for a cluster of 10 workers running [upstream Kubernetes v1.19](https://github.com/kubernetes/kubernetes). An [accompanying repository with Ansible playbooks](https://github.com/torgeirl/kubernetes-playbooks) can be used to build a suitable test cluster.

### Allocatable and reserved resources
A worker node with 1 CPU and 4 GB RAM has the following resources allocatable for pods:
  - 900 millicores CPU (90%)
  - 3972 megabyte RAM (97.5%)

These pods will share resources with the Kubernetes system services running on the worker node:
  - Kubelet agent
  - network proxy (`kube-proxy`)
  - Docker (container runtime)
  - Flannel (container subnet)

Flannel requests 100m CPU (10%) and 50Mi RAM (1.3%) as part of its deployment configuration. Reserving compute resources for the other system services has to be [set during cluster initialization](https://v1-19.docs.kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/). 

Boreas has options to reserve CPU and RAM for all the system services, but to ensure comparable test results vs Kubernetes' default scheduler both these values needs to be set to only match the requests from Flannel in `src/settings.ini`:
  - `ReservedKubletCPU = 100`
  - `ReservedKubletRAM = 50`

## Tests
  - Test1: deployment based on Google's [«Online Boutique: Cloud-Native Microservices Demo Application»](https://github.com/GoogleCloudPlatform/microservices-demo)(Apache-2.0 license), deploying a webstore to two worker nodes with just enough resources (cordon excess worker nodes before running this test).

## Running the evaluation tests
Build a test cluster with 10 workers configured with 1 CPUs and 4 GB RAM each.

Configure Boreas to use Zephyrus with the ortool solver:
  - Add `Options = --solver, lex-or-tools` under `[optimizer]` in `src/settings.ini`.
  - Deploy Boreas from a local Docker registry (described in README).

Run the tests as regular Kubernetes deployments, ie:
  - `$ kubectl create -f deployments/2021-paper/test1-boreas`

List all pods sorted by worker node:
  - `$ kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName --sort-by="{.spec.nodeName}"` 
