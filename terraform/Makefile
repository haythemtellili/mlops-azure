include .env

# Target: create-resource-group
create-resource-group:
	az group create --location $(LOCATION) --name $(RESOURCE_GROUP_NAME)

create-service-principal:
	az ad sp create-for-rbac --name $(SERVICE_PRINCIPAL_NAME) --role contributor --scopes /subscriptions/$(SUBSCRIPTION_ID)/resourceGroups/$(RESOURCE_GROUP_NAME) --sdk-auth

# Target: init-staging
init-staging:
	cd environments/staging && terraform init

# Target: plan-staging
plan-staging:
	cd environments/staging && terraform plan

# Target: apply-staging
apply-staging:
	cd environments/staging && terraform apply

# Target: init-prod
init-prod:
	cd environments/prod && terraform init

# Target: plan-prod
plan-prod:
	cd environments/prod && terraform plan

# Target: apply-prod
apply-prod:
	cd environments/prod && terraform apply

