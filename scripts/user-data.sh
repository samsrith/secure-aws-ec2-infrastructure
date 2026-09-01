#!/bin/bash
set -euo pipefail

dnf install -y httpd
systemctl enable --now httpd

# Request an IMDSv2 token before reading instance metadata.
TOKEN=$(curl -fsS -X PUT \
  "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

metadata() {
  curl -fsS \
    -H "X-aws-ec2-metadata-token: ${TOKEN}" \
    "http://169.254.169.254/latest/meta-data/$1"
}

INSTANCE_ID=$(metadata "instance-id")
AZ=$(metadata "placement/availability-zone")
INSTANCE_TYPE=$(metadata "instance-type")

cat > /var/www/html/index.html <<EOFHTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Secure AWS Cloud Infrastructure</title>
</head>
<body>
  <h1>Secure AWS Cloud Infrastructure</h1>
  <p>Cloud support portfolio lab</p>
  <ul>
    <li><strong>Instance ID:</strong> ${INSTANCE_ID}</li>
    <li><strong>Availability Zone:</strong> ${AZ}</li>
    <li><strong>Instance Type:</strong> ${INSTANCE_TYPE}</li>
    <li><strong>Status:</strong> Healthy and running</li>
  </ul>
</body>
</html>
EOFHTML
