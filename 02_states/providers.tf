terraform {
  backend "local" {
    # The path to the state file is specified here. It is currently set to an absolute path.
    # You can change this to a relative path if needed, for example: "state-file/terraform.tfstate"
    path= "/Users/manishyadav/Downloads/terraform_mysql_node_course/02_state/state-file/terraform.tfstate"
  }
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
  }
}