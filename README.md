# jenkins-testing
# Some Jenkins testing with add-hoc

##  How to run this code. 
1. Install the following software:
   terraform https://developer.hashicorp.com/terraform/install 
   aws cli https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
2. Create Aws free tier account  https://aws.amazon.com/free/
3. Create aws user with prgramtic access. 

\\
IAM roles are typically used to grant permissions to AWS services, applications, or other AWS accounts. By assuming an IAM role, an entity can temporarily acquire the permissions associated with that role.
\\
4. Create AWS user programtic access , aws-access key and secret.

\\
$ export AWS_ACCESS_KEY_ID="my-access-key"
$ export AWS_SECRET_ACCESS_KEY="my-secret-key"
\\
5. How to run 

Run following commands from aws directory of this repo.

1- git clone 
2- cd jenkins-testing/aws
3- run commands.

    terraform init 
    terraform plan # ( Review plan )
    terraform apply


