# rearc_quest_solution
this repo is the solution for rearc quest using terraform and docker over AWS
# rearc_quest_solution_ayush

1. you need to install the terraform and configure the aws user with correct IAM policy which can manage EC2,VPC,ALB
2. After cloning this repo and go to rearc_quest_solution_ayush and run below command

terraform init 

3. run below command to check the plan

terraform  plan
 
5. run below command to provision the infra.

terraform  apply  --auto-approve

6. to destory infra first delete the alb resource and then complete infra

 terraform  destroy -target=module.myapp-alb  

 terraform  destroy
