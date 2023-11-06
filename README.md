# Azure Machine Learning Operations (Azure MLOps)

This repository contains instructions and scripts for managing Azure MLOps workflows.
## Prerequisites

Ensure that you have the following prerequisites:

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
## Getting Started

Follow these steps to prepare the required resources for this Project:

### Infrastructure Preparation:
Create a file named .env in the root directory and define the following environment variables:

```shell
LOCATION="Your Azure Region"
RESOURCE_GROUP_NAME="Your Resource Group Name"
SERVICE_PRINCIPAL_NAME="Your Service Principal Name"
SUBSCRIPTION_ID="Your Azure Subscription ID"
```

Create an Azure Resource Group:
 ```
make create-resource-group
 ```

Create an Azure Service Principal:
 ```
make create-service-principal
 ```
#### Staging Environment:
Initialize Terraform (Staging):
 ```
make init-staging
 ```
Plan Terraform (Staging):
 ```
make plan-staging
 ```
Apply Terraform (Staging):
 ```
make apply-staging
 ```
#### Production Environment:
Initialize Terraform (Production):
 ```
make init-prod
 ```
Plan Terraform (Production):
 ```
make plan-prod
 ```
Apply Terraform (Production):
 ```
make apply-prod
 ```
## MLOps with AzureML
This section outlines the MLOps processes with AzureML, covering various aspects from environment setup to data management,
model training, deployment and monitoring to facilitate end-to-end machine learning operations.

### Environment Setup

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

### Data Management

Create curated data:
 ```
az ml data create -f data/curated.yml
 ```
Create online inference data:
 ```
az ml data create -f data/inference-online.yml
 ```
### Model Training

Train models using pipelines:
 ```
az ml job create -f jobs/pipelines/train_models.yml
 ```

### Model Deployment

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

### Model Monitoring

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
First, to capture custom logs from the online managed endpoint diagnostic settings must be configured to collect logs from the online managed endpoint and send them to a Log Analytics workspace. The following resource available here can be used to learn how to configure this.

Once logs have been collected, to filter and parse inference data from custom logs the following query can be executed in Log Analytics:

```
 AmlOnlineEndpointConsoleLog
| where TimeGenerated > ago (1d)
| where Message has 'online/credit-card-default' and Message has 'InputData'
| project TimeGenerated, ResponsePayload=split(Message, '|')
| project TimeGenerated, InputData=parse_json(tostring(ResponsePayload[-1])).data
| project TimeGenerated, InputData=parse_json(tostring(InputData))
| mv-expand InputData
| evaluate bag_unpack(InputData)
```

To view overall data drift metrics the following query can be executed in Log Analytics:
```
traces
| where message has 'credit-card-default' and message has 'OverallDriftMetrics'
| project timestamp, data=parse_json(tostring(message)).data
| evaluate bag_unpack(data)
```
To view feature level data drift metrics the following query can be executed in Log Analytics:
```
traces
| where message has 'credit-card-default' and message has 'FeatureDriftMetrics'
| project timestamp, data=parse_json(tostring(message)).data
| mv-expand data
| evaluate bag_unpack(data)
```

 ### Cleanup
Delete online endpoint:
 ```
 az ml online-endpoint delete --name credit-card-ep -y
 ```
 
### Automate Workflow with CI/CD
To bring it all together and automate your workflow, we will utilize GitHub Actions. This will enable us to create workflows that automate tasks and seamlessly transition between staging and production environments.

## Next Steps:
- Review and Define Alerting and Monitoring Rules Using Application Insights