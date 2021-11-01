resource "aws_instance" "ec2" {
  ami               = "ami-0c1a7f89451184c8b"
  instance_type     = "t2.micro"
  availability_zone = var.ZONE1
  key_name          = "terraform-devops-key"
  tags = {
    Name = "Terraform-ansible-ec2"
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo hostnamectl set-hostname myec2.cloudbook.com"
      
    ]
    connection {
      host        = aws_instance.ec2.public_dns
      type        = "ssh"
      user        = var.USERNAME
      private_key = file("./terraform-devops-key.pem")
    }
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.ec2.public_dns} > inventory"
  }
  

  provisioner "local-exec" {
    command = "ansible all -m shell -a 'yum -y install httpd; systemctl restart httpd; yum install docker -y; systemctl restart docker'"
    
  }
}
