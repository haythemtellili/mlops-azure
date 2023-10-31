# Azure Machine Learning Operations (Azure MLOps)

This repository contains instructions and scripts for managing Azure ML Ops workflows.

## Environment Setup

1. Create training environment:
 ```
az ml environment create -f environments/train.yml
 ```

2. Create scoring environment:
 ```
az ml environment create -f environments/score.yml
 ```

3. Create drift environment:
 ```
az ml environment create -f environments/drift.yml
 ```

## Data Management

4. Create curated data:
 ```
az ml data create -f data/curated.yml
 ```
5. Create online inference data:
 ```
az ml data create -f data/inference-online.yml
 ```
## Model Training and Inference

6. Train models using pipelines:
 ```
az ml job create -f jobs/pipelines/train_models.yml
 ```

7. Export data:
 ```
az ml job create -f jobs/pipelines/data_export.yml
 ```
8. Monitor data drift:
 ```
az ml job create -f jobs/pipelines/data_drift.yml
 ```

9. Create online endpoint:
 ```
az ml online-endpoint create -f endpoints/online/endpoint.yml
 ```
10. Deploy online endpoint with all traffic:
 ```
 az ml online-deployment create -f endpoints/online/deployment.yml --all-traffic
 ```

11. Invoke the online endpoint:
 ```
 ENDPOINT_NAME=credit-card-default-oe
 az ml online-endpoint invoke --name $ENDPOINT_NAME --request-file endpoints/online/sample.json
 ```

12. Schedule data export and drift monitoring:
 ```
 az ml schedule create -f jobs/schedules/data_export.yml
 ```
 ```
 az ml schedule create -f jobs/schedules/data_drift.yml
 ```

## Cleanup

13. Delete online endpoint:
 ```
 az ml online-endpoint delete --name credit-card-default-oe -y
 ```


## Next Steps:
- Configure Environment Variables in YML Files
- Set Up AzureML Compute and Enable Access to Blob Storage (Consider Managed Identities)
- Choose Between GitHub Actions or Azure DevOps for CI/CD
- Review and Define Alerting and Monitoring Rules Using Application Insights
