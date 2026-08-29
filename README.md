# Secure & Monitored AWS EC2 Web Infrastructure

A hands-on AWS cloud infrastructure project focused on secure networking, IAM role-based access, monitoring, alerting, auditing, and network traffic visibility.

## Project Overview

This project demonstrates how multiple AWS services work together to build a secure and monitored EC2-based web infrastructure.

The environment includes:

- Custom VPC
- Public and private subnets
- Internet Gateway
- Public route table
- Amazon EC2 web server
- Security Groups
- IAM role-based access
- Amazon CloudWatch
- Amazon SNS
- AWS CloudTrail
- Amazon S3
- VPC Flow Logs

## Architecture

![AWS Architecture](architecture/aws-architecture.png)

### Architecture Flow

- Internet → Internet Gateway → Public Route Table → Public Subnet → EC2
- EC2 → IAM Role → S3 / CloudWatch
- EC2 Metrics → CloudWatch → Alarms → SNS → Email
- AWS API Activity → CloudTrail → S3
- VPC Traffic → VPC Flow Logs → CloudWatch Logs

## Security Design

- SSH access restricted
- HTTP allowed for the web server
- Private resources protected using a separate security group
- MySQL access allowed only from the web-server security group
- IAM role used instead of hard-coded AWS credentials
- Least-privilege PassRole permissions used during deployment

## Monitoring and Alerting

CloudWatch was used to monitor:

- CPU utilization
- Network traffic
- EC2 status checks
- Billing threshold

Configured alarms:

- `high-cpu-alarm`
- `status-check-alarm`
- `billing-alarm`

Amazon SNS was used to deliver email notifications when alarms entered the ALARM state.

- `AuthorizeSecurityGroupIngress`
- `StartInstances`
Verified traffic states:

- `REJECT`

## Key Learnings

- VPC Flow Logs — records allowed and blocked network traffic

See the `architecture` folder for the project architecture diagram.

## Screenshots

See the `screenshots` folder for implementation evidence including:
- VPC and subnet configuration
- Route table
- Security groups
- EC2 instance
- CloudWatch alarms
- CloudWatch dashboard
- CloudTrail events
- VPC Flow Logs

## Cleanup


## Project Status

Completed ✅
EOFAfter completing the project and capturing all required evidence, the AWS resources were removed to avoid unnecessary charges.
- IAM role verification

## Architecture Diagram

- CloudWatch — monitors infrastructure health
- CloudTrail — records AWS account activity
- SNS — sends notifications
- IAM Roles — control AWS service permissions
- Security Groups — control network access

This project helped me understand the difference between:
- `ACCEPT`
VPC Flow Logs were enabled for the custom VPC and delivered to CloudWatch Logs.



## Network Visibility
CloudTrail logs were stored in Amazon S3.

- `StopInstances`
Verified events included:


AWS CloudTrail was configured to record management activity.
## Auditing

