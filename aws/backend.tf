terraform {
  backend "s3" {
    bucket         = "zaftech-terraform"  # Replace with your bucket name
    key            = "zaftech-terraform-demo/terraform.tfstate"
    region         = "us-east-1"                  # Replace with your bucket region
    # dynamodb_table = "zaftech-terraform"    # Optional, for state locking
    encrypt        = true
  }
}
