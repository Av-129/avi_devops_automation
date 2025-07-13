#!/bin/bash

REGION="ap-south-1"  # Change this to your desired region

# Directory to store the output
OUTPUT_DIR="abc-testing"
mkdir -p $OUTPUT_DIR

# Function to get all CodeBuild projects
get_codebuild_projects() {
    echo "Fetching all CodeBuild projects from Account A in region $REGION..."

    PROJECT_NAMES=$(aws codebuild list-projects --region $REGION --query "projects" --output text)
    
    if [ -z "$PROJECT_NAMES" ]; then
        echo "No CodeBuild projects found in region $REGION."
    else
        for PROJECT_NAME in $PROJECT_NAMES; do
            echo "Fetching details for CodeBuild project: $PROJECT_NAME"
            aws codebuild batch-get-projects --names $PROJECT_NAME --region $REGION > "$OUTPUT_DIR/codebuild-$PROJECT_NAME-$REGION.json"
            echo "Details for CodeBuild project '$PROJECT_NAME' saved to $OUTPUT_DIR/codebuild-$PROJECT_NAME-$REGION.json"
        done
    fi
}

# Function to get all CodePipelines
get_codepipelines() {
    echo "Fetching all CodePipelines from Account A in region $REGION..."

    PIPELINES=$(aws codepipeline list-pipelines --region $REGION --query "pipelines[*].name" --output text)

    if [ -z "$PIPELINES" ]; then
        echo "No CodePipelines found in region $REGION."
    else
        for PIPELINE in $PIPELINES; do
            echo "Fetching details for pipeline: $PIPELINE"
            aws codepipeline get-pipeline --name $PIPELINE --region $REGION > "$OUTPUT_DIR/codepipeline-$PIPELINE-$REGION.json"
            echo "Details for CodePipeline '$PIPELINE' saved to $OUTPUT_DIR/codepipeline-$PIPELINE-$REGION.json"
        done
    fi
}

# Function to get all CodeDeploy configurations
get_codedeploy_configs() {
    echo "Fetching all CodeDeploy configurations from Account A in region $REGION..."

    APPLICATIONS=$(aws deploy list-applications --region $REGION --query "applications" --output text)

    if [ -z "$APPLICATIONS" ]; then
        echo "No CodeDeploy applications found in region $REGION."
    else
        for APPLICATION in $APPLICATIONS; do
            echo "Fetching details for CodeDeploy application: $APPLICATION"
            aws deploy get-application --application-name $APPLICATION --region $REGION > "$OUTPUT_DIR/codedeploy-application-$APPLICATION-$REGION.json"
            echo "Details for CodeDeploy application '$APPLICATION' saved to $OUTPUT_DIR/codedeploy-application-$APPLICATION-$REGION.json"

            # Fetch deployment groups for the application
            DEPLOYMENT_GROUPS=$(aws deploy list-deployment-groups --application-name $APPLICATION --region $REGION --query "deploymentGroups" --output text)

            for GROUP in $DEPLOYMENT_GROUPS; do
                echo "Fetching details for deployment group: $GROUP in application: $APPLICATION"
                aws deploy get-deployment-group --application-name $APPLICATION --deployment-group-name $GROUP --region $REGION > "$OUTPUT_DIR/codedeploy-deployment-group-$APPLICATION-$GROUP-$REGION.json"
                echo "Details for deployment group '$GROUP' saved to $OUTPUT_DIR/codedeploy-deployment-group-$APPLICATION-$GROUP-$REGION.json"
            done
        done
    fi
}

# Call the functions
get_codebuild_projects
get_codepipelines
get_codedeploy_configs

echo "Script execution completed. Check the $OUTPUT_DIR directory for the output files."