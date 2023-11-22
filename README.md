# jenkins-testing
# Some Jenkins testing with add-hoc

##  How to run this code. 
1. Install terraform
   terraform https://developer.hashicorp.com/terraform/install
2. Install aws cli
   aws cli https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
3. Create Aws free tier account  https://aws.amazon.com/free/
4. Create aws user with programtic access. 

\\
IAM roles are typically used to grant AWS services, applications, or other AWS accounts permissions. By assuming an IAM role, an entity can temporarily acquire the permissions associated with that role.
\\
4. Create AWS user programmatic access , aws-access key and secret.

\\
$ export AWS_ACCESS_KEY_ID="my-access-key"
$ export AWS_SECRET_ACCESS_KEY="my-secret-key"
\\
5. How to run 

Run the following commands from aws directory of this repo.

1- git clone 
2- cd Jenkins-testing/aws
3- run commands.

    terraform init 
    terraform plan # ( Review plan )
    terraform apply


