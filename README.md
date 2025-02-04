# kubernetes-deployment-strategy

Kubernetes Deployment Strategy

https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy

[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/mit)

In this guide, we will explore various approaches to deploying applications on Kubernetes, including rolling updates, blue-green deployments, and canary releases, to help you achieve seamless and efficient application updates.

## 🚀 Features

- **Kubernetes**: Open source system for automating deployment, scaling, and management of containerized applications.
  - Deployment Strategies
    - **Rolling Update** is a way to update your application without causing downtime. Imagine you’re switching out parts of a machine while it’s still running. Instead of stopping the machine and replacing everything at once, you replace one part at a time. Similarly, Kubernetes updates your application one piece at a time, ensuring that it stays operational throughout the update process.
    - **Recreate** means completely stopping your old version of an application and then starting a new version from scratch. It’s like tearing down an old building and building a new one in its place. During this process, the application will be temporarily unavailable while the old version is replaced with the new one.
    - **Blue/Green** involves running two identical environments, Blue and Green. You deploy the new version to the Green environment, test it, and then switch user traffic from Blue to Green to ensure a smooth transition with minimal risk.
    - **Canary** is a method where you gradually release a new version of your application to a small portion of users before rolling it out to everyone. This helps test the new version in real conditions and minimize the risk of widespread issues.
    - **Feature flag deployment** involves using settings or configurations to turn specific features on or off in your application without changing the code. This allows you to control which features are active in your app by adjusting settings in Kubernetes, making it easier to test and manage new features.

## 🧰 Prerequisites

- Minikube

## 🛠 Installation

```bash
# Install dependencies
make install
```

## 📚 Usage

### App Commands

```bash
make install                            # Install dependencies
make run-k8s                            # Start the kubernetes (minikube)

make stop-rabbitmq                      # Stop rabbitmq related components

make deploy-rabbitmq                    # Deploy rabbitmq 3
make deploy-rabbitmq-rollingupdate      # Deploy rabbitmq 4 with rolling update strategy
make deploy-rabbitmq-recreate           # Deploy rabbitmq 4 with recreate strategy
make deploy-rabbitmq-blue               # Deploy rabbitmq 3 with blue/green strategy (blue)
make deploy-rabbitmq-green              # Deploy rabbitmq 4 with blue/green strategy (green)
make deploy-rabbitmq-canary             # Deploy rabbitmq 3 and 4 with canary strategy (50%)
make deploy-rabbitmq-featureflag        # Deploy rabbitmq 3 and feature flag

make run-rabbitmq                       # Portforward port 8080 to k8s service
```

after `make run-rabbitmq`, open `http://0.0.0.0:8080` in your web browser to access the UI.

#### To access app directly via Istio Gateway

```bash
make deploy-rabbitmq-featureflag-istio  # Deploy rabbitmq 3, 4 and feature flag with Istio
minikube tunnel                         # Open tunnel
http://127.0.0.1/                       # Access the UI
```

## 🤝 Contributing

We welcome contributions to Kubernetes Deployment Strategy! Please see the [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to submit pull requests, report issues, and suggest improvements.

## 📜 License

Backstage Getting Started is open-source software licensed under the [MIT license](http://www.apache.org/licenses/mit).

## 🙏 Acknowledgements

- [Kubernetes](https://kubernetes.io/) for the amazing framework
- All our contributors and supporters!

---

Made with ❤️ by the raymondsquared. Happy coding!
