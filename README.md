# IaC_Terraform

This is a Terraform Project for infrastructure automation on AWS. The project was divided into 2 parts: the infrastructure and the application.

The infrastructure is composed of:
- 1 Kubernetes Cluster AWS EKS (Amazon Elastic Kubernetes Service).
- 3 t2.small instances for the EKS cluster that will be the worker nodes.

Deploying:
```
aws eks --region us-east-1 update-kubeconfig --name sopas-eks 
ansible-playbook playbook.yml --ask-become-pass
```
