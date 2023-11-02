# Azure Machine Learning Operations (Azure MLOps)

This repository contains instructions and scripts for managing Azure MLOps workflows.
## Prerequisites

Ensure that you have the following prerequisites:

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
## Getting Started

Follow these steps to prepare the required resources using the Makefile:

```shell
# Environment Configuration:
Create a file named .env in the project root directory and define the following environment variables:

```shell
LOCATION="Your Azure Region"
RESOURCE_GROUP_NAME="Your Resource Group Name"
SERVICE_PRINCIPAL_NAME="Your Service Principal Name"
SUBSCRIPTION_ID="Your Azure Subscription ID"

## Infrastructure Using Terraform

Initialize Terraform:
 ```
terraform init
 ```

Generate a Terraform plan to preview changes:
 ```
terraform plan
 ```
Apply Terraform Changes:
 ```
terraform apply
 ```

## Environment Setup

Create training environment:
 ```
az ml environment create -f environments/train.yml
 ```

Create scoring environment:
 ```
az ml environment create -f environments/score.yml
 ```

Create drift environment:
 ```
az ml environment create -f environments/drift.yml
 ```

## Data Management

Create curated data:
 ```
az ml data create -f data/curated.yml
 ```
Create online inference data:
 ```
az ml data create -f data/inference-online.yml
 ```
## Model Training

Train models using pipelines:
 ```
az ml job create -f jobs/pipelines/train_models.yml
 ```

## Model Deployment

Create online endpoint:
 ```
az ml online-endpoint create -f endpoints/online/endpoint.yml
 ```
Deploy online endpoint with all traffic:
 ```
 az ml online-deployment create -f endpoints/online/deployment.yml --all-traffic
 ```

Invoke the online endpoint:
 ```
 ENDPOINT_NAME=credit-card-default-oe
 az ml online-endpoint invoke --name $ENDPOINT_NAME --request-file endpoints/online/sample.json
 ```

## Model Monitoring

Export data:
 ```
az ml job create -f jobs/pipelines/data_export.yml
 ```
Monitor data drift:
 ```
az ml job create -f jobs/pipelines/data_drift.yml
 ```
Schedule data export and drift monitoring:
 ```
 az ml schedule create -f jobs/schedules/data_export.yml
 ```
 ```
 az ml schedule create -f jobs/schedules/data_drift.yml
 ```

## Cleanup

Delete online endpoint:
 ```
 az ml online-endpoint delete --name credit-card-default-oe -y
 ```


## Next Steps:
- Configure Environment Variables in YML Files
- terraform modules
- Review and Define Alerting and Monitoring Rules Using Application Insights
- Choose Between GitHub Actions or Azure DevOps for CI/CD
