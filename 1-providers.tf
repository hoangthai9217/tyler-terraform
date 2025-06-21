terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "ap-southeast-1"
}