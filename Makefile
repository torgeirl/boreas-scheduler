.ONESHELL:
deploy-locally:
	buildah build -t boreas-scheduler:local .
	buildah push --tls-verify=false boreas-scheduler:local docker://localhost:5000/boreas-scheduler:local
	kubectl create -f deployments/scheduler-local.yaml

.ONESHELL:
remove:
	kubectl delete deployment --namespace=kube-system boreas-scheduler
	kubectl delete clusterrolebinding --namespace=kube-system boreas-scheduler-as-kube-scheduler
	kubectl delete serviceaccount --namespace=kube-system boreas-scheduler

start-registry:
	@podman run -d --name local-registry -p 5000:5000 --restart=always docker.io/library/registry:2 || \
	docker run -d --name local-registry -p 5000:5000 --restart=always registry:2

stop-registry:
	@podman rm -f local-registry 2>/dev/null || docker rm -f local-registry 2>/dev/null || true
