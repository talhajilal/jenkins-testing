# *** Sample Terraform code #
# This is a simple project to demonstrate the use of Terraform create VPC, deploy aws ec2 instance and install Jenkins.
## Pre-requisites:
1. Install terraform on your local machine from https://www.terraform.io/downloads.html.
2. Install aws cli  .
3. Aws account ( Read more about aws free tier for testing ).
4. AWS Programatic key acces.

## Set your desire name in main.tf.

i.e 
}
module "vpc" {
    source = "./vpc"
    vpc_name = "zaftech-kube1"   # Change zaftech with your desire name.
}

module "zaftech-esg" {
  source            = "./security/security_group"
  security_group_name = "zaftech-esg"   
  security_group_vpc_id  = "${module.vpc.vpc_id}"
  security_group_description = "zaftech-ec2-security-group"
  security_group_tags = {
    Name   = "zaftech"
    env    = "Dev"
  }
}

## Backend for remote terraform state.
    bucket         = "zaftech-terraform"  # Replace with your bucket name
    key            = "zaftech-terraform-demo/terraform.tfstate"   #( Replace with your source directory path in s3 bucket.)

## How to Run 
Run following commands from aws directory of this repo.

1- git clone 
2- cd jenkins-testing/aws
3- run commands.

    terraform init 
    terraform plan # ( Review plan )
    terraform apply
