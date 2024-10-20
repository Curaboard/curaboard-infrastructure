## VPC
variable "vpc_id" {
  description = "Default VPC"
  type        = string
  default     = "vpc-0c8333df3981a06e7"
}

## Subnet
variable "subnet_id1" {
  description = "Subnet ID"
  type        = string
  default     = "subnet-0b33c3fba4800ac56"
}

variable "subnet_id2" {
  description = "Subnet ID"
  type        = string
  default     = "subnet-08cf99b276d5227e1"
}

variable "subnet_id3" {
  description = "Subnet ID"
  type        = string
  default     = "subnet-040f02bb9a4453b79"
}

# #ECR
variable "frontend_repo_name" {
  description = "ECR Name"
  type        = string
  default     = "curaboard/frontend"
}

variable "backend_repo_name" {
  description = "ECR Name"
  type        = string
  default     = "curaboard/backend"
}

variable "auth_repo_name" {
  description = "ECR Name"
  type        = string
  default     = "curaboard/auth"
}

variable "shopify_repo_name" {
  description = "ECR Name"
  type        = string
  default     = "curaboard/shopify"
}

# EKS
variable "eks_repo_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "curaboard-cluster"
}

variable "node_group_name" {
  description = "EKS Node Group Name"
  type        = string
  default     = "curaboard-node-group"
}

variable "instance_type" {
  description = "Instance Size"
  type        = list(string)
  default     = ["t3.medium"] #["t3a.medium"]
}

#S3 for Helm Chart
variable "s3_helm" {
  description = "Name of the S3 bucket that hosts our Helm Chart"
  type        = string
  default     = "curaboard-helm-chart-01"
}