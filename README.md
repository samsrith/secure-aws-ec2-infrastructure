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

[Architecture Flow]

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

- CPU utilizon
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

## Implementation Screenshots

# 1. IAM User Creation
Created the `infra-admin` IAM user for day-to-day project administration.

# 2. MFA Security
Enabled MFA for the IAM user to improve account security.

# 3. EC2 IAM Role
Created the EC2 web server role and attached the required permission policies.

# 4. Custom VPC
Created a custom VPC with separate public and private subnets.

# 5. Public Subnet
Configured the public subnet for internet-facing resources.


# 6. Private Subnet
Created a private subnet to demonstrate network segmentation.

# 7. Internet Gateway
Attached an Internet Gateway to the custom VPC.

# 8. Public Route Table
Configured the public route table with a default route through the Internet Gateway.

# 9. Security Groups
Configured inbound rules for HTTP, restricted SSH, and private resource access.

# 10. EC2 Instance
Launched the Amazon Linux web server in the public subnet.

# 11. IAM Role Verification from EC2
Verified role-based access using `aws s3 ls` and `aws sts get-caller-identity`.

# 12. EC2 Webpage
Verified the Apache webpage running from the EC2 instance and displaying instance metadata.

# 13. CloudWatch Alarms
Configured CPU, status-check, and billing alarms.

# 14. CPU Alarm Test
Generated high CPU usage and verified the alarm entered the ALARM state.

# 15. SNS Email Alert
Verified that the monitoring alarm triggered an email notification.

# 16. CloudTrail
Configured AWS CloudTrail for infrastructure auditing.

# 17. CloudTrail Event History
Reviewed AWS management events recorded by CloudTrail.

# 18. CloudTrail JSON Record
Reviewed the detailed JSON audit record for a CloudTrail event.

# 19. StartInstances Audit Event
Verified that starting the EC2 instance was recorded by CloudTrail.

# 20. StopInstances Audit Event
Verified that stopping the EC2 instance was recorded.

# 21. StopInstances JSON
Reviewed the full CloudTrail JSON record for the stop-instance action.

# 22. VPC Flow Logs
Enabled VPC Flow Logs and delivered network records to CloudWatch Logs.

# 23. ACCEPT Traffic
Verified permitted network connections using ACCEPT flow-log records.

# 24. REJECT Traffic
Verified blocked network connections using REJECT flow-log records.

# 25. ACCEPT and REJECT Comparison
Captured both allowed and blocked network activity in the VPC Flow Logs.

# 26. Allowed HTTP Test
Verified successful HTTP access to the EC2 web server.

# 27. Blocked Port Test
Verified that traffic to an unauthorized port was blocked.


## Challenges & What I Learned

During this project, I ran into several real AWS permission and connectivity issues and learned how to troubleshoot them.

- Learned why `AmazonEC2FullAccess` does not automatically include IAM permissions.
- Understood how `iam:PassRole` allows a user to attach a specific IAM role to an AWS service without granting full IAM access.
- Used an EC2 IAM role instead of storing AWS access keys on the instance.
- Troubleshot EC2 Instance Connect by allowing the correct AWS-managed prefix list for SSH access.
- Learned how CloudWatch alarms, SNS notifications, and dashboards work together for monitoring.
- Verified AWS API activity using CloudTrail event history and JSON event records.
- Configured VPC Flow Logs with a dedicated service role and verified both `ACCEPT` and `REJECT` network traffic.
- Practiced least-privilege IAM by granting only the permissions required for each task.

### Key Takeaway

This project helped me understand the difference between:

**Security Groups** → control network access 
**IAM Roles** → control AWS permissions 
**CloudWatch** → monitors infrastructure health 
**SNS** → sends alerts 
**CloudTrail** → records AWS API activity 
**VPC Flow Logs** → records allowed and blocked network traffic

## Clean Ups
- VPC and subnet configuration
- Route table
- Security groups
- EC2 instance
- CloudWatch alarms
- CloudWatch dashboard
- CloudTrail events
- VPC Flow Logs

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

