#!/bin/bash

# Function to ask for user input
ask_input() {
  local prompt="$1"
  read -p "$prompt: " input
  echo "$input"
}

# Function to get environment variables as a JSON array
get_env_vars() {
  local cluster_name="$1"
  local aws_account="$2"
  local repository_uri="$3"
  local prepaid_engine_secret="$4"

  echo "[{\"name\":\"CLUSTER_NAME\",\"value\":\"$cluster_name\",\"type\":\"PLAINTEXT\"},
          {\"name\":\"AWS_ACCOUNT\",\"value\":\"$aws_account\",\"type\":\"PLAINTEXT\"},
          {\"name\":\"REPOSITORY_URI\",\"value\":\"$repository_uri\",\"type\":\"PLAINTEXT\"},
          {\"name\":\"MDMS_PREPAID_ENGINE_SECRET\",\"value\":\"$prepaid_engine_secret\",\"type\":\"PLAINTEXT\"}]"
}

# Load all pipeline names from pipeline.txt
PIPELINE_NAMES=$(cat pipeline.txt)

# Predefined variables (common for all pipelines)
GITHUB_SOURCE="mdms-api"
GITHUB_BRANCH="vb1"
CLUSTER_NAME="gomati-pre-prod-eks"
AWS_ACCOUNT="205930611114"
REPOSITORY_URI="205930611114.dkr.ecr.ap-south-1.amazonaws.com"
MDMS_PREPAID_ENGINE_SECRET="/dev/gomati/mdms-prepaid-engine"
CODESTAR_ARN="arn:aws:codeconnections:ap-south-1:205930611114:connection/f07d6322-6150-4411-b2c3-416c6177d082"
CODEPIPELINE_ROLE_ARN="arn:aws:iam::205930611114:role/codepipeline-role-management"
CODEBUILD_ROLE_ARN="arn:aws:iam::205930611114:role/codebuild-role-dev"
S3_BUCKET_NAME="codepipeline-ap-south-1-205930611114"
AWS_REGION="ap-south-1"

# Buildspec file path (same for all pipelines)
DEV_BUILD_SPEC="./devops/buildspec"
STAGE_BUILD_SPEC="./devops/buildspec"
GOMATI_BUILD_SPEC="./devops/buildspec"
SARYU_BUILD_SPEC="./devops/buildspec"

# Iterate over all pipeline names and create pipeline for each
for PIPELINE_NAME in $PIPELINE_NAMES; do
  echo "Creating pipeline: $PIPELINE_NAME"

  # Environment variables for all build projects
  DEV_ENV_VARS=$(get_env_vars "$CLUSTER_NAME" "$AWS_ACCOUNT" "$REPOSITORY_URI" "$MDMS_PREPAID_ENGINE_SECRET")
  STAGE_ENV_VARS=$(get_env_vars "$CLUSTER_NAME" "$AWS_ACCOUNT" "$REPOSITORY_URI" "$MDMS_PREPAID_ENGINE_SECRET")
  GOMATI_ENV_VARS=$(get_env_vars "$CLUSTER_NAME" "$AWS_ACCOUNT" "$REPOSITORY_URI" "$MDMS_PREPAID_ENGINE_SECRET")
  SARYU_ENV_VARS=$(get_env_vars "$CLUSTER_NAME" "$AWS_ACCOUNT" "$REPOSITORY_URI" "$MDMS_PREPAID_ENGINE_SECRET")

  # Generate build project names based on the pipeline name
  DEV_BUILD_PROJECT_NAME="${PIPELINE_NAME}-dev"
  STAGE_BUILD_PROJECT_NAME="${PIPELINE_NAME}-stage"
  GOMATI_BUILD_PROJECT_NAME="${PIPELINE_NAME}-GOMATI"
  SARYU_BUILD_PROJECT_NAME="${PIPELINE_NAME}-saryu"

  # Function to create a CodeBuild project for ARM
  create_codebuild_project() {
    local project_name=$1
    local env_vars=$2
    local buildspec=$3
    local region=$4

    aws codebuild create-project --name "$project_name" \
      --source "{\"type\": \"CODEPIPELINE\"}" \
      --artifacts "{\"type\": \"CODEPIPELINE\"}" \
      --environment "{
        \"computeType\": \"BUILD_GENERAL1_LARGE\",
        \"type\": \"ARM_CONTAINER\",
        \"image\": \"aws/codebuild/amazonlinux2-aarch64-standard:3.0\",
        \"environmentVariables\": $env_vars
      }" \
      --service-role "$CODEBUILD_ROLE_ARN" \
      --region "$region"
  }

  # Create CodeBuild projects for dev, stage, GOMATI, and saryu environments
  echo "Creating CodeBuild projects for pipeline: $PIPELINE_NAME"
  create_codebuild_project "$DEV_BUILD_PROJECT_NAME" "$DEV_ENV_VARS" "$DEV_BUILD_SPEC" "$AWS_REGION"
  create_codebuild_project "$STAGE_BUILD_PROJECT_NAME" "$STAGE_ENV_VARS" "$STAGE_BUILD_SPEC" "$AWS_REGION"
  create_codebuild_project "$GOMATI_BUILD_PROJECT_NAME" "$GOMATI_ENV_VARS" "$GOMATI_BUILD_SPEC" "$AWS_REGION"
  create_codebuild_project "$SARYU_BUILD_PROJECT_NAME" "$SARYU_ENV_VARS" "$SARYU_BUILD_SPEC" "$AWS_REGION"
  echo "CodeBuild projects created successfully for $PIPELINE_NAME."

  # Create the pipeline JSON
  PIPELINE_JSON=$(cat <<EOF
{
  "pipeline": {
    "name": "$PIPELINE_NAME",
    "roleArn": "$CODEPIPELINE_ROLE_ARN",
    "stages": [
      {
        "name": "Source",
        "actions": [
          {
            "name": "Source",
            "actionTypeId": {
              "category": "Source",
              "owner": "AWS",
              "provider": "CodeStarSourceConnection",
              "version": "1"
            },
            "outputArtifacts": [
              {
                "name": "SourceArtifact"
              }
            ],
            "configuration": {
              "ConnectionArn": "$CODESTAR_ARN",
              "FullRepositoryId": "$GITHUB_SOURCE",
              "BranchName": "$GITHUB_BRANCH"
            },
            "runOrder": 1
          }
        ]
      },
      {
        "name": "DevBuild",
        "actions": [
          {
            "name": "DevBuild",
            "actionTypeId": {
              "category": "Build",
              "owner": "AWS",
              "provider": "CodeBuild",
              "version": "1"
            },
            "inputArtifacts": [
              {
                "name": "SourceArtifact"
              }
            ],
            "configuration": {
              "ProjectName": "$DEV_BUILD_PROJECT_NAME"
            },
            "runOrder": 1,
            "roleArn": "$CODEBUILD_ROLE_ARN"
          }
        ]
      },
      {
        "name": "ApprovalForStage",
        "actions": [
          {
            "name": "ManualApprovalStage",
            "actionTypeId": {
              "category": "Approval",
              "owner": "AWS",
              "provider": "Manual",
              "version": "1"
            },
            "configuration": {
              "CustomData": "Approval needed before proceeding to stage"
            },
            "runOrder": 1
          }
        ]
      },
      {
        "name": "StageBuild",
        "actions": [
          {
            "name": "StageBuild",
            "actionTypeId": {
              "category": "Build",
              "owner": "AWS",
              "provider": "CodeBuild",
              "version": "1"
            },
            "inputArtifacts": [
              {
                "name": "SourceArtifact"
              }
            ],
            "configuration": {
              "ProjectName": "$STAGE_BUILD_PROJECT_NAME"
            },
            "runOrder": 1,
            "roleArn": "$CODEBUILD_ROLE_ARN"
          }
        ]
      },
      {
        "name": "ApprovalForGOMATI",
        "actions": [
          {
            "name": "ManualApprovalGOMATI",
            "actionTypeId": {
              "category": "Approval",
              "owner": "AWS",
              "provider": "Manual",
              "version": "1"
            },
            "configuration": {
              "CustomData": "Approval needed before proceeding to GOMATI"
            },
            "runOrder": 1
          }
        ]
      },
      {
        "name": "GOMATIBuild",
        "actions": [
          {
            "name": "GOMATIBuild",
            "actionTypeId": {
              "category": "Build",
              "owner": "AWS",
              "provider": "CodeBuild",
              "version": "1"
            },
            "inputArtifacts": [
              {
                "name": "SourceArtifact"
              }
            ],
            "configuration": {
              "ProjectName": "$GOMATI_BUILD_PROJECT_NAME"
            },
            "runOrder": 1,
            "roleArn": "$CODEBUILD_ROLE_ARN"
          }
        ]
      },
      {
        "name": "ApprovalForSaryu",
        "actions": [
          {
            "name": "ManualApprovalSaryu",
            "actionTypeId": {
              "category": "Approval",
              "owner": "AWS",
              "provider": "Manual",
              "version": "1"
            },
            "configuration": {
              "CustomData": "Approval needed before proceeding to saryu"
            },
            "runOrder": 1
          }
        ]
      },
      {
        "name": "SaryuBuild",
        "actions": [
          {
            "name": "SaryuBuild",
            "actionTypeId": {
              "category": "Build",
              "owner": "AWS",
              "provider": "CodeBuild",
              "version": "1"
            },
            "inputArtifacts": [
              {
                "name": "SourceArtifact"
              }
            ],
            "configuration": {
              "ProjectName": "$SARYU_BUILD_PROJECT_NAME"
            },
            "runOrder": 1,
            "roleArn": "$CODEBUILD_ROLE_ARN"
          }
        ]
      }
    ],
    "artifactStore": {
      "type": "S3",
      "location": "$S3_BUCKET_NAME"
    }
  }
}
EOF
)

  # Output pipeline JSON to a file for reference
  echo "$PIPELINE_JSON" > pipeline-${PIPELINE_NAME}.json
  echo "Pipeline configuration has been written to pipeline-${PIPELINE_NAME}.json"

  # Create the pipeline using the AWS CLI
  aws codepipeline create-pipeline --cli-input-json file://pipeline-${PIPELINE_NAME}.json --region "$AWS_REGION"

  echo "CodePipeline '$PIPELINE_NAME' has been created successfully."
  echo "Build projects created:"
  echo " - $DEV_BUILD_PROJECT_NAME"
  echo " - $STAGE_BUILD_PROJECT_NAME"
  echo " - $GOMATI_BUILD_PROJECT_NAME"
  echo " - $SARYU_BUILD_PROJECT_NAME"
done