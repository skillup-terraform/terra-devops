terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.2"
    }
  }
backend "s3" {
  bucket = "terra-157673692367"
  key = "test"
  region = "ap-south-1"
  dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}
