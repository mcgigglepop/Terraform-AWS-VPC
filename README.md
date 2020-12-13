# Terraform AWS VPC

The application in this repository will provision a fully managed virtual private cloud with infrastructure as code using the Terraform markup language.

### VPC Architecture
![Highlevel arch](/images/Terraform-AWS-VPC.png "VPC Architecture")

By default, the following resources will be provisioned in `us-east-1`:  

- An AWS VPC
- 2 Private Subnets
- 2 Public Subnets
- An External AWS Load Balancer
- A Public Bastion Host
- A Private EC2 Auto-scaling Group
- Cloudwatch Alarms for Healthy Load Balancer Nodes
- Docker RDS Container
- Docker Web Container
- An RDS Instance
- Additional Networking Resources (e.g. Nat Gateways, Elastic IP Addresses, etc.)
- Appropriate Security Group(s) and IAM Instance Profile(s)

### Application Requirements  

The following dependencies are required to deploy this application:  

- The AWS CLI with a default profile configured
- Terraform

### Terraform Remote State

This application uses an S3 Bucket to manage remote state. The remote state bucket format follows the following naming convention: `{SERVICENAME}-{STAGE}-remote-state`. This bucket needs to exist within your deployment environment before the application can be deployed.