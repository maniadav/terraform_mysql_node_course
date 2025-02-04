terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "ap-south-1"
  # shared_credentials_files = ["~/.aws/credentials"] # path to AWS credentials file
  # access_key = ""
  # secret_key = ""
  # profile                  = "vscode"               # profile name in credentials file
}
