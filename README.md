This is not fully working

The case is that I don't have an AWS account and I was not able to run it.

Prerequisites
* AWS Account to obtain credentials (AWS_KEY and AWS_SECRET) in `.aws/credentials`
* Account needs to have permissions to actually create/update resources (EC2, S3, ... etc) on AWS

  Structure
  * root: contains the definition of different modules to be configured
  * modules: contains the declarations for different modules like ec2, db, nat, vpc and security-group
  * We only have one api server and another db server. In case we need to replicate those, we need to include a load balancer module
