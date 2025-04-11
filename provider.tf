# Initialize with: terraform workspace new dev
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "project-backup-on-s3" 
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "myDynamoForLock"  
    encrypt        = true
  }
}


