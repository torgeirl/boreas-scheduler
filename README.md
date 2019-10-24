boreas-scheduler
=============

## Overview

## Deploy Boreas scheduler
You can deploy the Boreas scheduler on your master node by either using Docker Hub (recommended), or by building it yourself and deploying it to a local Docker registry. The later is mostly useful for development of the Boreas scheduler itself.

You can see the scheduler's pod by listing pods in the system namespace:
  - `$ kubectl get pods --namespace=kube-system`

Pod description and logs are also available:
  - `$ kubectl describe pod boreas-scheduler --namespace=kube-system`
  - `$ kubectl logs boreas-scheduler-<pod-identifier> boreas-scheduler --namespace=kube-system`

### Deploy from Docker Hub
  - `$ kubectl create -f deployments/scheduler.yaml`

### Deploy from local Docker registry
  - `$ sudo bash build/deploy-locally`

which deploys the scheduler locally in four steps:

(1) Build a Docker image:
  - `$ sudo docker build -t boreas-scheduler:local .`

(2) Tag the image and push it to your [local registry](https://docs.docker.com/registry/deploying/):
  - `$ sudo docker tag boreas-scheduler:local localhost:5000/boreas-scheduler:local`
  - `$ sudo docker push localhost:5000/boreas-scheduler:local`

(3) Remove the locally-cached images, and then pull the image from your registry:
  - `$ sudo docker image remove boreas-scheduler:local`
  - `$ sudo docker image remove localhost:5000/boreas-scheduler:local`
  - `$ sudo docker pull localhost:5000/boreas-scheduler:local`

(4) Deploy the sheduler to Kubernetes:
  - `$ kubectl create -f deployments/scheduler-local.yaml`

## Remove Boreas scheduler
  - `$ bash build/remove`

which removes the scheduler by running the following:
  - `$ kubectl delete deployment --namespace=kube-system boreas-scheduler`
  - `$ kubectl delete clusterrolebinding --namespace=kube-system boreas-scheduler-as-kube-scheduler`
  - `$ kubectl delete serviceaccount --namespace=kube-system boreas-scheduler`

## Credits
  - Jacopo Mauro: [Zephyrus2](https://bitbucket.org/jacopomauro/zephyrus2)
  - Nick Joyce: «[Building Minimal Docker Containers for Python Applications](https://blog.realkinetic.com/building-minimal-docker-containers-for-python-applications-37d0272c52f3)» ([Dockerfile](Dockerfile) design)

## License
See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
