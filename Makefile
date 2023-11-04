include .env

create-resource-group:
	az group create --location $(LOCATION) --name $(RESOURCE_GROUP_NAME)

create-service-principal:
	az ad sp create-for-rbac --name $(SERVICE_PRINCIPAL_NAME) --role contributor --scopes /subscriptions/$(SUBSCRIPTION_ID)/resourceGroups/$(RESOURCE_GROUP_NAME) --sdk-auth

init-staging:
	cd terraform/environments/staging && terraform init

plan-staging:
	cd terraform/environments/staging && terraform plan

apply-staging:
	cd terraform/environments/staging && terraform apply

init-prod:
	cd terraform/environments/prod && terraform init

plan-prod:
	cd terraform/environments/prod && terraform plan

apply-prod:
	cd terraform/environments/prod && terraform apply

run-all: create-resource-group create-service-principal init-staging apply-staging init-prod apply-prod


