#!/bin/bash

# Set Account B details
#ACCOUNT_B_ID="222222222222"  # Replace with Account B ID
REGION="ap-south-1"          # Replace with your region

# Check if ecr_repos.txt exists
if [ ! -f ecr_repos.txt ]; then
  echo "ecr_repos.txt file not found. Please run the first script to generate this file."
  exit 1
fi

# Read the repository names from the file and create new repos in Account B
while read -r REPO; do
    # Skip empty lines
    if [[ -z "$REPO" ]]; then
        continue
    fi
    
    echo "Creating repositories for $REPO in Account B..."
    
    # Create dev, stage, abc, and abc repositories
    for SUFFIX in "-dev" "-stage" "-abc" "-abc"; do
        NEW_REPO="$REPO$SUFFIX"
        if ! aws ecr describe-repositories --region $REGION --repository-names $NEW_REPO >/dev/null 2>&1; then
            echo "Creating repository $NEW_REPO in Account B"
            aws ecr create-repository --region $REGION --repository-name $NEW_REPO
        else
            echo "Repository $NEW_REPO already exists in Account B"
        fi
    done

done < ecr_repos.txt

echo "ECR repositories have been created in Account B with the required suffixes."