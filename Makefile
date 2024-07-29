.PHONY: run-k8s
run-k8s:
	minikube start --driver=docker

.PHONY: stop-rabbitmq
stop-rabbitmq:
	kubectl delete deployment rabbitmq || true
	kubectl delete deployment rabbitmq-blue || true
	kubectl delete deployment rabbitmq-green || true

.PHONY: install-rabbitmq
install-rabbitmq:
	docker pull rabbitmq:3-management
	docker pull rabbitmq:4.0.0-beta.3-management

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

.PHONY: run-rabbitmq
run-rabbitmq:
	kubectl port-forward service/rabbitmq 8080:80
