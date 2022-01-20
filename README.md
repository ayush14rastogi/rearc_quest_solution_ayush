# rearc_quest_solution
this repo is the solution for rearc quest using terraform and docker over AWS
# rearc_quest_solution_ayush

# Prerequiste you should have one S3 bucket and update the bucket name in config/backend.conf 

1. you need to install the terraform and configure the aws user with correct IAM policy which can manage S3,EC2,VPC,ALB
2. After cloning this repo and go to rearc_quest_solution_ayush and run below command

terraform init -backend-config=config/backend.conf

3. run below command to provision the infra.

  terraform  apply  --auto-approve
