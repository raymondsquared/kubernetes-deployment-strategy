# kubernetes-deployment-strategy

Kubernetes Deployment Strategy

https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy

[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/mit)

In this guide, we will explore various approaches to deploying applications on Kubernetes, including rolling updates, blue-green deployments, and canary releases, to help you achieve seamless and efficient application updates.

## 🚀 Features

- **Kubernetes**: Open source system for automating deployment, scaling, and management of containerized applications.

### Deployment Strategies
- A "Rolling Update" in Kubernetes is a way to update your application without causing downtime. Imagine you’re switching out parts of a machine while it’s still running. Instead of stopping the machine and replacing everything at once, you replace one part at a time. Similarly, Kubernetes updates your application one piece at a time, ensuring that it stays operational throughout the update process.

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
make deploy-rabbitmq      # Deploy rabbitmq 3
make deploy-rabbitmq-rollingupdate      # Deploy rabbitmq 4 with rolling update strategy
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
