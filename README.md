# curaboard-infrastructure
This repo is for all AWS infrastructure which will be setup for the EKS migration process

### Use Terraform to create the infrastructure
```
terraform init
./run.sh
```

### Create Helm chart
- Connect to the EKS cluster, then run the following commands
```
helm package curaboard
aws s3 cp curaboard-0.1.0.tgz s3://curaboard-helm-chart-01/
helm repo index . --url s3://curaboard-helm-chart-01/
aws s3 cp index.yaml s3://curaboard-helm-chart-01/
helm plugin install https://github.com/hypnoglow/helm-s3.git
helm s3 init s3://curaboard-helm-chart-01/
helm repo add curaboard s3://curaboard-helm-chart-01/
helm repo update
```

- Apply EKS configuration
```
kubectl apply -f eks-config
```