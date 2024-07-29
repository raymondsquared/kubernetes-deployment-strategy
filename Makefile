.PHONY: run-k8s
run-k8s:
	minikube start --driver=docker

.PHONY: install-rabbitmq
install-rabbitmq:
	docker pull rabbitmq:3-management
	docker pull rabbitmq:4.0.0-beta.3-management

.PHONY: deploy-rabbitmq
deploy-rabbitmq: install-rabbitmq
	kubectl apply -f rabbitmq-deployment.yaml

.PHONY: deploy-rabbitmq-rollingupdate
deploy-rabbitmq-rollingupdate:
	kubectl apply -f rabbitmq-deployment-rollingupdate.yaml

.PHONY: deploy-rabbitmq-recreate
deploy-rabbitmq-recreate:
	kubectl apply -f rabbitmq-deployment-recreate.yaml
