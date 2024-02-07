terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "webapp_instance" {
  ami = "ami-830c94e3" # might have to change this
  instance_type = "t2.micro"

  tags = {
    Name = "DiagnosyWebapp"
  }
}

resource "aws_instance" "mongodb_instance" {
  ami = "ami-830c94e3" # might have to change this
  instance_type = "t2.micro"

  tags = {
    Name = "DiagnosyDatabase"
  }
}
