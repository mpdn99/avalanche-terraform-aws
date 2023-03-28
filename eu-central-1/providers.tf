terraform {
    required_version = ">= 1.4.2"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 4.60.0"
        }
    }
    cloud {
        organization = "Solashi"
        workspaces {
            name = "avalanche-terraform-aws"
        }
    }
}

provider "aws" {
    region = "eu-central-1"
}