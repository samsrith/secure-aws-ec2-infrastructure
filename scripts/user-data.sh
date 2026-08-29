#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

# Retrieve EC2 instance metadata
TOKEN=$(curl -s -X PUT \
"http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -s \
-H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/instance-id)

AZ=$(curl -s \
-H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/placement/availability-zone)

INSTANCE_TYPE=$(curl -s \
-H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/instance-type)

cat > /var/www/html/index.html << EOFHTML
<!DOCTYPE html>
<html>
<head>
  <title>Secure AWS Cloud Infrastructure</title>
</head>
<body>
  <h1>Secure AWS Cloud Infrastructure</h1>
  <p>Junior Cloud Engineer Portfolio Project</p>

  <p><strong>Instance ID:</strong> $INSTANCE_ID</p>
  <p><strong>Availability Zone:</strong> $AZ</p>
  <p><strong>Instance Type:</strong> $INSTANCE_TYPE</p>
  <p><strong>Status:</strong> Healthy and Running</p>
</body>
</html>
