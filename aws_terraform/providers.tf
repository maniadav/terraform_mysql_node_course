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
  # also provide adminstator access policy
  access_key = "" // check IAM credentials who has administrator access
  secret_key = "" // you can also find it in , cd ~/.aws/credentials and then nano -v credentials
  # profile                  = "vscode"               # profile name in credentials file
}
