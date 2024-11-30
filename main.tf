terraform {
  required_providers {
    source = "hashicorp/aws"
    version = "~> 3.79"

  }
  
}

resource "aws_instance" "myserver" {
    ami = "ami-09b0a86a2c84101e1"
    instance_type = "t2.micro"

    tags = {
      name = "jenkins_terraform_server"

    }

  
}


resource "aws_s3_bucket" "self_bucket" {
    bucket = "jenkins-terraform-bucket"
    
}