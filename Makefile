.PHONY: run-k8s
run-k8s:
	minikube start --driver=docker

.PHONY: stop-rabbitmq
stop-rabbitmq:
	kubectl delete ingress rabbitmq-ingress || true
	kubectl delete service rabbitmq || true
	kubectl delete service rabbitmq-canary-a || true
	kubectl delete service rabbitmq-canary-b || true
	kubectl delete service rabbitmq-featureflag || true
	kubectl delete deployment rabbitmq || true
	kubectl delete deployment rabbitmq-blue || true
	kubectl delete deployment rabbitmq-green || true
	kubectl delete deployment rabbitmq-canary-a || true
	kubectl delete deployment rabbitmq-canary-b || true
	kubectl delete deployment rabbitmq-featureflag || true
	kubectl delete configmap rabbitmq-featureflag || true

.PHONY: install-rabbitmq
install-rabbitmq:
	docker pull rabbitmq:3-management
	docker pull rabbitmq:4.0.0-beta.3-management

.PHONY: install-ingress
install-ingress:
	minikube addons enable ingress

.PHONY: install
install: install-rabbitmq

.PHONY: deploy-rabbitmq
deploy-rabbitmq: stop-rabbitmq
	kubectl apply -f rabbitmq-deployment.yaml
	kubectl apply -f rabbitmq-service.yaml

.PHONY: deploy-rabbitmq-rollingupdate
deploy-rabbitmq-rollingupdate:
	kubectl apply -f rabbitmq-deployment-rollingupdate.yaml

.PHONY: deploy-rabbitmq-recreate
deploy-rabbitmq-recreate:
	kubectl apply -f rabbitmq-deployment-recreate.yaml

.PHONY: deploy-rabbitmq-blue
deploy-rabbitmq-blue: stop-rabbitmq
	kubectl apply -f rabbitmq-deployment-blue.yaml
	kubectl apply -f rabbitmq-deployment-green.yaml
	kubectl apply -f rabbitmq-service-bluegreen.yaml

.PHONY: deploy-rabbitmq-green
deploy-rabbitmq-green:
	@export DEPLOYMENT_GROUP="green"; \
		kubectl patch service rabbitmq -p "{\"spec\": {\"selector\": {\"deployment-group\": \"$$DEPLOYMENT_GROUP\"}}}"

.PHONY: deploy-rabbitmq-canary
deploy-rabbitmq-canary: stop-rabbitmq
	kubectl apply -f rabbitmq-deployment-canary-a.yaml
	kubectl apply -f rabbitmq-deployment-canary-b.yaml
	kubectl apply -f rabbitmq-services-canary.yaml
	kubectl apply -f rabbitmq-ingress-canary.yaml

.PHONY: deploy-rabbitmq-featureflag
deploy-rabbitmq-featureflag: stop-rabbitmq
	kubectl apply -f rabbitmq-configmap-featureflag.yaml
	kubectl apply -f rabbitmq-deployment-featureflag.yaml
	kubectl apply -f rabbitmq-services-featureflag.yaml

.PHONY: run-rabbitmq
run-rabbitmq:
	kubectl port-forward service/rabbitmq 8080:80 \
	|| kubectl port-forward svc/ingress-nginx-controller 8080:80 -n ingress-nginx
