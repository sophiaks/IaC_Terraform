# IaC_Terraform

This is a Terraform Project for infrastructure automation on AWS. The project was divided into 2 parts: the infrastructure and the application.

![](https://img.shields.io/badge/-AmazonEKS-informational?style=flat&logo=AmazonEKS&logoColor=white&color=FF9900)
![](https://img.shields.io/badge/-AmazaonEC2-informational?style=flat&logo=aws&logoColor=white&color=FF9900)


The infrastructure is composed of:
- 1 Kubernetes Cluster AWS EKS (Amazon Elastic Kubernetes Service).
- 3 t2.small instances for the EKS cluster that will be the worker nodes.

Deploying:
```
aws eks --region us-east-1 update-kubeconfig --name sopas-eks 
ansible-playbook playbook.yml --ask-become-pass
```
