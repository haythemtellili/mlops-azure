include .env

# Target: create-resource-group
create-resource-group:
	az group create --location $(LOCATION) --name $(RESOURCE_GROUP_NAME)

create-service-principal:
	az ad sp create-for-rbac --name $(SERVICE_PRINCIPAL_NAME) --role contributor --scopes /subscriptions/$(SUBSCRIPTION_ID)/resourceGroups/$(RESOURCE_GROUP_NAME) --sdk-auth

# Target: init-staging
init-staging:
	cd terraform/environments/staging && terraform init

# Target: plan-staging
plan-staging:
	cd terraform/environments/staging && terraform plan

# Target: apply-staging
apply-staging:
	cd terraform/environments/staging && terraform apply

# Target: init-prod
init-prod:
	cd terraform/environments/prod && terraform init

# Target: plan-prod
plan-prod:
	cd terraform/environments/prod && terraform plan

# Target: apply-prod
apply-prod:
	cd terraform/environments/prod && terraform apply

# Target: run-all (Runs all the targets)
run-all: create-resource-group create-service-principal init-staging apply-staging init-prod apply-prod


