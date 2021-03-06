resource "aws_instance" "ec2" {
  ami               = var.AMIS
  instance_type     = "t2.micro"
  availability_zone = var.ZONE1
  key_name          = "terraform-devops-key"
  subnet_id	    = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.mywebsg.id]
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
    command = "chmod 600 ./terraform-devops-key.pem"
	  
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.ec2.public_dns} > inventory"
  }
  

  provisioner "local-exec" {
    command = "ansible all -m shell -a 'yum -y install httpd; systemctl restart httpd; yum install docker -y; systemctl restart docker'"
    
  }
}
