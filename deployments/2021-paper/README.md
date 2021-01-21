## Overview
The deployments in this directory are designed for a cluster running [upstream Kubernetes v1.19](https://github.com/kubernetes/kubernetes). An [accompanying repository with Ansible playbooks](https://github.com/torgeirl/kubernetes-playbooks) can be used to build a suitable test cluster.

### Allocatable and reserved resources
Deployed service pods on a worker node has to share compute resources with the Kubernetes system services running on the worker node:
  - Kubelet agent
  - network proxy (`kube-proxy`)
  - Docker (container runtime)
  - Flannel (container subnet)

Flannel requests 100m CPU (10%) and 50Mi RAM (1.3%) as part of its deployment configuration. This leaves a worker node with 1 CPU and 4 GB RAM with the following resources allocatable for pods:
  - 900 millicores CPU (90%)
  - 3972 megabyte RAM (97.5%)

Reserving compute resources for the other system services has to be [set during cluster initialization](https://v1-19.docs.kubernetes.io/docs/tasks/administer-cluster/reserve-compute-resources/) for the default scheduler. Boreas has options to reserve CPU and RAM for all the system services, but to ensure comparable test results vs Kubernetes' default scheduler both these values needs to be set to only match the requests from Flannel in `src/settings.ini`:
  - `ReservedKubletCPU = 100`
  - `ReservedKubletRAM = 50`

## Tests
  - Test1: minimal deployment with two-tier service for two worker nodes with just enough resources (cordon excess worker nodes before running this test).

  - Test2: deployment with affinity/anti-affinity constraints, deploying a four-tier service to four worker notes with just enough resources (cordon excess worker nodes before running this test).

## Running the evaluation tests
Build a test cluster with worker nodes configured with 1 CPUs and 4 GB RAM each. When a test requires fewer nodes than the cluster has available excess worker nodes should be [cordoned](https://v1-19.docs.kubernetes.io/docs/concepts/architecture/nodes/#manual-node-administration) in order to recreate the test scenario fully.

Run the tests as regular Kubernetes deployments, ie:
  - `$ kubectl create -f deployments/2021-paper/test1-boreas`

List all pods sorted by worker node (helpfull when evaluation service placement):
  - `$ kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName --sort-by="{.spec.nodeName}"` 
