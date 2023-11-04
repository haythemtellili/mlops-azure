#!/bin/bash

# Define an array of storage account names and their corresponding keys
declare -A storage_accounts=(
  [$STORAGE_ACCOUNT_1_NAME]=$STORAGE_ACCOUNT_1_KEY
  [$STORAGE_ACCOUNT_2_NAME]=$STORAGE_ACCOUNT_2_KEY
)
# Define the source and destination paths
source_path="./data"
destination_path="./data"

for account_name in "${!storage_accounts[@]}"; do
  account_key="${storage_accounts[$account_name]}"
  CONTAINER_NAME=$(az storage container list --account-name "$account_name" --account-key "$account_key" --query "[].name" | grep "azureml-blobstore-*" | tr -d ',' | xargs)
  az storage blob upload-batch --destination "$CONTAINER_NAME" --account-name "$account_name" --account-key "$account_key" --destination-path "$destination_path" --source "$source_path"
done