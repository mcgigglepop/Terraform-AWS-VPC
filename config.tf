provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile = "sandbox"    
}
terraform {
    backend "s3" {
        profile = "sandbox"
        bucket  = "appvpc-qa-remote-state"
        key     = "terraform-states/sls-deployers/terraform-aws-vpc-deployment.tfstate"
        region  = "us-east-1"
    }
}

data "aws_region" "current" {}