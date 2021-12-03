boreas-scheduler
=============

![Docker](https://github.com/torgeirl/boreas-scheduler/workflows/Docker/badge.svg)

## Overview

## Deploy Boreas scheduler
You can deploy the Boreas scheduler on your master node by either pulling it from the Github Container Registry (recommended), or by building it yourself and deploying it to a local Docker registry. The later is mostly useful for development of the Boreas scheduler itself.

You can see the scheduler's pod by listing pods in the system namespace:
  - `$ kubectl get pods --namespace=kube-system`

Pod description and logs are also available:
  - `$ kubectl describe pod boreas-scheduler --namespace=kube-system`
  - `$ kubectl logs boreas-scheduler-<pod-identifier> boreas-scheduler --namespace=kube-system`

### Deploy from the Github Container Registry
  - `$ kubectl create -f deployments/scheduler.yaml`

### Deploy from local Docker registry
Deploy a [local Docker registry](https://docs.docker.com/registry/deploying/):
  - `$ docker run -d -p 5000:5000 --restart=always --name registry registry:2`

Then run the deployment script:
  - `$ bash build/deploy-locally`

which deploys the scheduler locally in four steps:

(1) Build a Docker image:
  - `$ docker build -t boreas-scheduler:local .`

(2) Tag the image and push it to your local registry:
  - `$ docker tag boreas-scheduler:local localhost:5000/boreas-scheduler:local`
  - `$ docker push localhost:5000/boreas-scheduler:local`

(3) Remove the locally-cached images, and then pull the image from your registry:
  - `$ docker image remove boreas-scheduler:local`
  - `$ docker image remove localhost:5000/boreas-scheduler:local`
  - `$ docker pull localhost:5000/boreas-scheduler:local`

(4) Deploy the sheduler to Kubernetes:
  - `$ kubectl create -f deployments/scheduler-local.yaml`

## Remove Boreas scheduler
  - `$ bash build/remove`

which removes the scheduler by running the following:
  - `$ kubectl delete deployment --namespace=kube-system boreas-scheduler`
  - `$ kubectl delete clusterrolebinding --namespace=kube-system boreas-scheduler-as-kube-scheduler`
  - `$ kubectl delete serviceaccount --namespace=kube-system boreas-scheduler`

## Advanced optimizer settings
Boreas can be configured to include options with the optimizing requests sent to Zephyrus2 through an optional `Options` setting. The setting must be set under `[optimizer]` in `src/settings.ini` before deploying Boreas from a local Docker registry.

Details on the available options can be found in [Zephyrus2's documentation](https://bitbucket.org/jacopomauro/zephyrus2), but options include:
  - disabling Zephyrus2's symmetry breaking constraint: `--no-simmetry-breaking`
  - using [the OR-Tools solver](https://developers.google.com/optimization/): `--solver, lex-or-tools`
  - using [the Gecode solver](https://github.com/Gecode/gecode): `--solver, gecode`
  - using the Z3 SMT solver: `--solver, smt`

For instance, the following will instruct Zephyrus2 to use OR-Tools as its solver:
  - Add `Options = --solver, lex-or-tools`

## Credits
  - Jacopo Mauro: [Zephyrus2](https://bitbucket.org/jacopomauro/zephyrus2)
  - Nick Joyce: «[Building Minimal Docker Containers for Python Applications](https://blog.realkinetic.com/building-minimal-docker-containers-for-python-applications-37d0272c52f3)» ([Dockerfile](Dockerfile) design)

## Citation
If you use this software in your research, please cite is at described in [CITATION](CITATION).

## License
See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
