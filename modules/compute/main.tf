# Public Instances
resource "aws_instance" "Apachepub1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids["us-east-1a"]
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  provisioner "local-exec" {
    command = "echo The Public ip of 1st public instance ${self.public_ip} >> ./machineIPs.txt"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("${var.key_name}.pem")
    }
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl enable --now httpd",
      "sudo mkdir -p /var/www/html",
      "echo \"Hello System admins Track.... Thank U Public 1\" | sudo tee /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html",
      "sudo systemctl restart httpd"
    ]
  }
}

resource "aws_instance" "Apachepub2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids["us-east-1b"]
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name


  provisioner "local-exec" {
    command = "echo The Public ip of 2nd public instance ${self.public_ip} >> ./machineIPs.txt"
  }

  user_data = <<-EOT
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable --now httpd
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --reload
sudo mkdir -p /var/www/html
echo "Hello System admins Track.... Thank U Public 2" | sudo tee /var/www/html/index.html
sudo chmod 644 /var/www/html/index.html
sudo systemctl restart httpd
EOT
}

# Private Instances
resource "aws_instance" "Apachepriv1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids["us-east-1a"]
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  provisioner "local-exec" {
    command = "echo The Private ip of 1st private instance ${self.private_ip} >> ./machineIPs.txt"
  }

  provisioner "remote-exec" {
    connection {
      type                = "ssh"
      user                = "ec2-user"
      host                = self.private_ip
      private_key         = file("${var.key_name}.pem")
      bastion_host        = aws_instance.Apachepub1.public_ip
      bastion_user        = "ec2-user"
      bastion_private_key = file("${var.key_name}.pem")
    }
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl enable --now httpd",
      "sudo mkdir -p /var/www/html",
      "echo \"Hello System admins Track.... Thank U Private 1\" | sudo tee /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html",
      "sudo systemctl restart httpd"
    ]
  }
}

resource "aws_instance" "Apachepriv2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids["us-east-1b"]
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  provisioner "local-exec" {
    command = "echo The Private ip of 2nd private instance ${self.private_ip} >> ./machineIPs.txt"
  }
# user data "Best Practice" 
  user_data = <<-EOT
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable --now httpd
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --reload
sudo mkdir -p /var/www/html
echo "Hello System admins Track.... Thank U Private 2" | sudo tee /var/www/html/index.html
sudo chmod 644 /var/www/html/index.html
sudo systemctl restart httpd
EOT
}

# Target Group Attachments
resource "aws_lb_target_group_attachment" "public1" {
  target_group_arn = var.public_lb_arn
  target_id        = aws_instance.Apachepub1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "public2" {
  target_group_arn = var.public_lb_arn
  target_id        = aws_instance.Apachepub2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "private1" {
  target_group_arn = var.private_lb_arn
  target_id        = aws_instance.Apachepriv1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "private2" {
  target_group_arn = var.private_lb_arn
  target_id        = aws_instance.Apachepriv2.id
  port             = 80
}