output "apache_pub1_ip" {
  value = aws_instance.Apachepub1.public_ip
}

output "apache_pub2_ip" {
  value = aws_instance.Apachepub2.public_ip
}

output "apache_priv1_ip" {
  value = aws_instance.Apachepriv1.private_ip
}

output "apache_priv2_ip" {
  value = aws_instance.Apachepriv2.private_ip
}