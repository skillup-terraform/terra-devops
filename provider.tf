terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.2"
    }
  }
backend "s3" {
bucket = "asdfasdf"
}
}

provider "aws" {
  region = "us-east-1"
}
