.ONESHELL:
deploy-locally:
        buildah bud -t boreas-scheduler:local .
        buildah push --tls-verify=false boreas-scheduler docker://localhost:5000/boreas-scheduler:local
        kubectl create -f deployments/scheduler-local.yaml

.ONESHELL:
remove:
        kubectl delete deployment --namespace=kube-system boreas-scheduler
        kubectl delete clusterrolebinding --namespace=kube-system boreas-scheduler-as-kube-scheduler
        kubectl delete serviceaccount --namespace=kube-system boreas-scheduler

.ONESHELL:
start-registry:
        registryctr=$$(buildah from docker.io/library/registry:2)
        buildah run --net=host $$registryctr /entrypoint.sh /etc/docker/registry/config.yml &

.ONESHELL:
stop-registry:
        buildah rm registry-working-container
        kill -9 $$(pgrep registry)
