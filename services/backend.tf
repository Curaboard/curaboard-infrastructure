terraform {
  backend "s3" {
    bucket = "terraform-state-files-4-eks-migration"
    key    = "migration/state-files"
    region = "us-east-2"
  }
}

