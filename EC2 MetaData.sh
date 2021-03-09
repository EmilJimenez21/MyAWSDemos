#!/bin/bash

# Install Apache Web Server 
yum install httpd -y
systemctl start httpd
systemctl enable httpd

# Discovery configuration from using the EC2 metadata service
ID=$(curl 169.254.169.254/latest/meta-data/instance-id)
TYPE=$(curl 169.254.169.254/latest/meta-data/instance-type)
AZ=$(curl 169.254.169.254/latest/meta-data/placement/availability-zone)
IPV4=$(curl -f 169.254.169.254/latest/meta-data/public-ipv4)

# Set up the Web Site
cd /var/www/html

## Generate customized index.html for this instance
cat <<EOT > ./index.html
<html>
<head>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css' integrity='sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2' crossorigin='anonymous'>
</head>
<body style='background: #e6e6e6; text-align: center;'>
<div class='text-center mt-4'>
<img src='https://github.com/EmilJimenez21/MyAWSDemos/blob/main/aws.png?raw=true' style='width: 250px'>
<H1>Hello, EC2 Instance!</H1>
<p>The ID of this instance is <strong>$ID</strong></p>
<p>This is a <strong>$TYPE</strong> instance in <strong>$AZ</strong></p>
<p>The IPv4 address is <strong>$IPV4</strong></p>
</div>
</body>
</html>
EOT
