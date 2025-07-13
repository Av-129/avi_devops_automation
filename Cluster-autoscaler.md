Cluster Autoscaler (CA) Setup and Troubleshooting Guide for AWS EKS 

Overview 

Cluster Autoscaler (CA) automatically adjusts the number of nodes in your Kubernetes cluster based on the resource demands. This guide covers the configuration and troubleshooting steps for setting up Cluster Autoscaler (CA) on AWS EKS, using IAM roles, RBAC, and Helm deployment. It also addresses common issues encountered during the setup and their resolutions. 

Shape 

Cluster Autoscaler Configuration 
 
helm repo add autoscaler https://kubernetes.github.io/autoscaler 

helm repo update 

 

values.yaml Configuration 

This file configures Cluster Autoscaler with the following parameters: 

autoDiscovery: 

  clusterName: abc-pre-prod-eks 

 

awsRegion: ap-south-1 

 

env: 

  - name: AWS_REGION 

    value: ap-south-1 

 

extraArgs: 

  scale-down-delay-after-add: 2m 

  scale-down-delay-after-delete: 1m 

  scale-down-enabled: "true" 

  scale-down-unneeded-time: 2m 

  scale-down-utilization-threshold: "0.5" 

 

rbac: 

  create: true 

  extraRules: 

    - apiGroups: ["storage.k8s.io"] 

      resources: ["volumeattachments"] 

      verbs: ["list", "watch"] 

 

serviceAccount: 

  create: false  # ⬅️ Set to false since SA already exists 

  name: autoscaler-aws-cluster-autoscaler 

 

priorityClassName: system-cluster-critical 

 

podDisruptionBudget: 

  enabled: true 

  maxUnavailable: 1  # ⬅️ Use maxUnavailable instead of minAvailable 

 

resources: 

  requests: 

    cpu: 100m 

    memory: 300Mi 

  limits: 

    cpu: 200m 

    memory: 600Mi 

 

nodeSelector: {} 

 

tolerations: 

  - key: "node-role.kubernetes.io/control-plane"  # ⬅️ If your nodes use "control-plane" instead of "master" 

    operator: "Exists" 

    effect: "NoSchedule" 

 

affinity: {} 

 

replicaCount: 1 

 
Complete cluster-autoscaler.yaml 
 
autoDiscovery: 

  clusterName: abc-ipv6-eks  # Update to your EKS cluster name 

 

awsRegion: ap-south-1 

 

env: 

  - name: AWS_REGION 

    value: ap-south-1 

 

extraArgs: 

  scale-down-delay-after-add: 2m 

  scale-down-delay-after-delete: 1m 

  scale-down-enabled: "true" 

  scale-down-unneeded-time: 2m 

  scale-down-utilization-threshold: "0.5" 

 

rbac: 

  create: true 

  extraRules: 

    - apiGroups: ["storage.k8s.io"] 

      resources: ["volumeattachments"] 

      verbs: ["list", "watch"] 

 

serviceAccount: 

  create: false  # SA is already created 

  name: autoscaler-aws-cluster-autoscaler 

 

priorityClassName: system-cluster-critical 

 

podDisruptionBudget: 

  enabled: true 

  maxUnavailable: 1 

 

resources: 

  requests: 

    cpu: 100m 

    memory: 300Mi 

  limits: 

    cpu: 200m 

    memory: 600Mi 

 

nodeSelector: {} 

 

tolerations: 

  - key: "node-role.kubernetes.io/control-plane" 

    operator: "Exists" 

    effect: "NoSchedule" 

 

affinity: {} 

 

replicaCount: 1 

 

Change the cluster name and region  in above yaml 

 

RBAC Configuration 

Cluster Autoscaler requires specific RBAC permissions. Below is the RBAC configuration: 

ClusterRole for required permissions: 

apiVersion: rbac.authorization.k8s.io/v1 

kind: ClusterRole 

metadata: 

  name: cluster-autoscaler 

rules: 

  - apiGroups: [""] 

    resources: 

      - events 

      - endpoints 

      - pods 

      - services 

      - nodes 

      - namespaces 

    verbs: ["watch", "list", "get"] 

 

  - apiGroups: ["storage.k8s.io"] 

    resources: 

      - volumeattachments 

    verbs: ["watch", "list", "get"] 

 

  - apiGroups: ["batch", "extensions"] 

    resources: 

      - jobs 

    verbs: ["get", "list", "watch", "patch", "create", "update", "delete"] 

 

  - apiGroups: ["apps"] 

    resources: 

      - replicasets 

    verbs: ["get", "list", "watch"] 

 

  - apiGroups: ["policy"] 

    resources: 

      - poddisruptionbudgets 

    verbs: ["get", "list", "watch"] 

 

  - apiGroups: ["autoscaling"] 

    resources: 

      - horizontalpodautoscalers 

    verbs: ["get", "list", "watch"] 

 

ClusterRoleBinding to bind the ClusterRole to the service account: 

 

apiVersion: rbac.authorization.k8s.io/v1 

kind: ClusterRoleBinding 

metadata: 

  name: cluster-autoscaler 

roleRef: 

  apiGroup: rbac.authorization.k8s.io 

  kind: ClusterRole 

  name: cluster-autoscaler 

subjects: 

  - kind: ServiceAccount 

    name: autoscaler-aws-cluster-autoscaler 

    namespace: kube-system 
 
 
Complete rbac cluster-autoscaler-rbac.yaml 
 
apiVersion: rbac.authorization.k8s.io/v1 

kind: ClusterRole 

metadata: 

  name: cluster-autoscaler 

rules: 

  - apiGroups: [""] 

    resources: 

      - events 

      - endpoints 

      - pods 

      - services 

      - nodes 

      - namespaces 

    verbs: ["watch", "list", "get"] 

 

  - apiGroups: ["storage.k8s.io"] 

    resources: 

      - volumeattachments 

    verbs: ["watch", "list", "get"] 

 

  - apiGroups: ["batch", "extensions"] 

    resources: 

      - jobs 

    verbs: ["get", "list", "watch", "patch", "create", "update", "delete"] 

 

  - apiGroups: ["apps"] 

    resources: 

      - replicasets 

    verbs: ["get", "list", "watch"] 

 

  - apiGroups: ["policy"] 

    resources: 

      - poddisruptionbudgets 

    verbs: ["get", "list", "watch"] 

 

  - apiGroups: ["autoscaling"] 

    resources: 

      - horizontalpodautoscalers 

    verbs: ["get", "list", "watch"] 

 

--- 

apiVersion: rbac.authorization.k8s.io/v1 

kind: ClusterRoleBinding 

metadata: 

  name: cluster-autoscaler 

roleRef: 

  apiGroup: rbac.authorization.k8s.io 

  kind: ClusterRole 

  name: cluster-autoscaler 

subjects: 

  - kind: ServiceAccount 

    name: autoscaler-aws-cluster-autoscaler 

    namespace: kube-system 

 

 

 

 

IAM Policy for Cluster Autoscaler 

Ensure that the IAM role used by Cluster Autoscaler has the following permissions: 

IAM Policy for Cluster Autoscaler which will be attached with iam role of EKS: 

{ 

    "Version": "2012-10-17", 

    "Statement": [ 

        { 

            "Effect": "Allow", 

            "Action": [ 

                "autoscaling:DescribeAutoScalingGroups", 

                "autoscaling:DescribeAutoScalingInstances", 

                "autoscaling:DescribeLaunchConfigurations", 

                "autoscaling:DescribeTags", 

                "autoscaling:SetDesiredCapacity", 

                "autoscaling:TerminateInstanceInAutoScalingGroup", 

                "ec2:DescribeInstanceTypes", 

                "ec2:DescribeLaunchTemplateVersions" 

            ], 

            "Resource": "*" 

        }, 

        { 

            "Effect": "Allow", 

            "Action": [ 

                "eks:DescribeNodegroup", 

                "eks:ListNodegroups", 

                "eks:DescribeCluster", 

                "eks:ListClusters" 

            ], 

            "Resource": "*" 

        } 

    ] 

} 

 

Create IAM role with below policy 
 
IAM Policy for EC2 Access: 

 

{ 

    "Version": "2012-10-17", 

    "Statement": [ 

        { 

            "Effect": "Allow", 

            "Action": [ 

                "autoscaling:DescribeAutoScalingGroups", 

                "autoscaling:SetDesiredCapacity", 

                "autoscaling:DescribeScalingActivities", 

                "autoscaling:UpdateAutoScalingGroup", 

                "autoscaling:TerminateInstanceInAutoScalingGroup", 

                "ec2:DescribeInstances", 

                "ec2:DescribeInstanceTypes", 

                "ec2:DescribeLaunchTemplateVersions", 

                "eks:DescribeNodegroup" 

            ], 

            "Resource": "*" 

        } 

    ] 

} 
 
 
Trust-relation  
{ 

    "Version": "2012-10-17", 

    "Statement": [ 

        { 

            "Effect": "Allow", 

            "Principal": { 

                "Federated": "arn:aws:iam::1212***:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/EBD73A99F0803F8DA94CAF5A7890DF71" 

            }, 

            "Action": "sts:AssumeRoleWithWebIdentity", 

            "Condition": { 

                "StringEquals": { 

                    "oidc.eks.ap-south-1.amazonaws.com/id/EBD73A99F0803F8DA94CAF5A7890DF71:sub": "system:serviceaccount:kube-system:cluster-autoscaler-aws-cluster-autoscaler" 

                } 

            } 

        } 

    ] 

} 

 

Change the account number and OIDC with the actual values 

 
 
 
Find the service account created in kube-system for cluster autoscaler 
 
Annotate it with the IAM we created in point 2.(below is powershell command for example) 
 
 
 
kubectl annotate serviceaccount cluster-autoscaler-aws-cluster-autoscaler ` 

  eks.amazonaws.com/role-arn=arn:aws:iam::1212**:role/eks-cluster-autoscaler-iam-role-binding ` 

  -n kube-system 

 

Change the arn when apply with the actual arn 

 

 

Helm Deployment for Cluster Autoscaler 

Use the following helm upgrade command to apply the values.yaml file and deploy Cluster Autoscaler: 
 
helm repo add autoscaler https://kubernetes.github.io/autoscaler 

helm repo update 

 

helm upgrade --install cluster-autoscaler stable/cluster-autoscaler \ 

--namespace kube-system \ 

--values values.yaml 

 

Ensure the service account is created beforehand and properly referenced as autoscaler-aws-cluster-autoscaler. 

 

Common Issues and Recovery Steps 

1. Cluster Autoscaler Pod Fails to Start 

Symptoms: Pod fails to start or remains in a crash loop. 

Possible Causes: 

Misconfigured IAM policy or missing permissions. 

Incorrect --nodes configuration in values.yaml. 

Solution: 

Check Logs: 
 
kubectl -n kube-system logs deployment/cluster-autoscaler 

 

Fix IAM Permissions: Ensure the IAM policy has the correct autoscaling and EC2 permissions as shown in the IAM policy section. 

Correct --nodes Flag: Make sure the correct Auto Scaling Group name and range (e.g., 1:10:your-nodegroup-name) is set. 

2. Cluster Autoscaler Does Not Scale Nodes 

Symptoms: Cluster Autoscaler does not scale nodes up or down as expected. 

Solution: 

Verify Resource Requests: Ensure that the pods are requesting more resources than are available on the current nodes. 

Check Auto Scaling Group Configuration: Verify that the minimum and maximum node counts are configured properly in the ASG. 

3. No Node Group Found 

Symptoms: Error stating "No Node Group Found for node". 

Solution: 

Verify Node Group Name: Ensure the node group name in values.yaml matches the actual ASG name. 

Ensure Proper Node Group Tags: The ASG should be tagged with kubernetes.io/cluster/<cluster-name>: owned. 

4. Cluster Autoscaler Does Not Scale Down Nodes 

Symptoms: Autoscaler does not scale down nodes even when resource utilization is low. 

Solution: 

Check Scale Down Configurations: Adjust the scale-down delay and utilization thresholds in extraArgs. 

Example: 
 
scale-down-delay-after-add: 2m 

scale-down-unneeded-time: 2m 

scale-down-utilization-threshold: "0.5" 

 

5. Cluster Autoscaler Not Working After Deployment 

Symptoms: Autoscaler is not scaling nodes after deployment. 

Solution: 

Check Service Account: Ensure that the service account is correctly referenced and has the necessary RBAC permissions. 

Validate RoleBinding: Make sure the ClusterRoleBinding is correctly set up. 

 

Conclusion 

With the above steps and configurations, you can successfully deploy and troubleshoot the AWS EKS Cluster Autoscaler. Always monitor logs and resource usage to ensure efficient scaling. Make sure to address IAM permissions and Auto Scaling Group configurations, as they are critical for proper scaling. 

This guide covers the primary issues you might encounter during setup and offers solutions for common problems. For continued optimization, regularly review resource usage and adjust scaling parameters accordingly. 

 

 

 

Useful link:- 
 
 https://www.eksworkshop.com/docs/autoscaling/compute/cluster-autoscaler/install  