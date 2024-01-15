## Prerequisites
1. Install and configure aws-cli
2. Install kubectl
3. Install terraform
4. Install jq

## Pre Deployment
- Navigate to the following directory
[code]
cd terraform/env/aktimize
[/code]
- Fill in all the relevant values in the **variables.tfvars** file

## Deployment
[code]
cd terraform/env/aktimize/

terraform init
terraform validate
terraform plan -var-file="variables.tfvars" -out terraform.plan
terraform apply terraform.plan
[/code]

## Post Deployment
1. Configure kubectl
    a. **Option one**: as part of the deployment a "config" file was created in the same directory (see above). You can use it to execute kubectl commands by using the --kubeconfig <path-to-file>
    b. **Option two**: you can use the file mentioned in "1.a" and override/merge-to your local ~/.kube/config
    b. **Option three**: You can execute the below command which will automatically update your ~/.kube/config file with the correct details
[code]
aws eks --region $(terraform output -raw aws_region) update-kubeconfig --name $(terraform output -raw eks_cluster_name)
[/code]
2. Deploy Cluster Autoscaler and Horizontal Pod Autoscaler
[code]
cd ../../../auto-scalers/

sed "s/PUT_ACCOUNT_ID_HERE/$(aws sts get-caller-identity | jq -r ".Account")/g" cluster-autoscaler.yaml
sed "s/PUT_CLUSTER_NAME_HERE/$(terraform output -raw eks_cluster_name)/g" cluster-autoscaler.yaml

kubectl apply -f cluster-autoscaler.yaml

cd hpa

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml
[/code]

## Cleanup of all the created resources
[code]
cd terraform/env/aktimize/

terraform destroy -var-file="variables.tfvars" --auto-approve
[/code]