terraform {
  backend "s3" {
    bucket = "ebloemer-bucket"
    key    = "ec2-ebloemer/terraform.state"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "ebloemer-bucket"
    key    = "vpc/terraform.state"
    region = "us-east-1"
  }
}