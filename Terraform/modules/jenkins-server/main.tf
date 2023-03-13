# data "aws_ami" "amazon-linux-2" {
#   most_recent = true

#   filter {
#     name   = "owner-alias"
#     values = ["amazon"]
#   }


#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm*"]
#   }

#   owners = ["amazon"]

# }
resource "tls_private_key" "rsa-jenkins" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "jenkins-key"
  public_key = tls_private_key.rsa-4096-jenkins.public_key_openssh
}

resource "local_file" "jenkins-key" {
  content = tls_private_key.rsa-jenkins.private_key_pem
  filename = "jkey"
}

resource "aws_instance" "jenkins-server" {
  ami             = "ami-0557a15b87f6559cf"
  instance_type   = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]

  provisioner "remote-exec" {
    inline = [
        "sudo mkdir testtttttt"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("D:\\Devops\\ragu-devops.pem")
  }

  tags = {
    "Name" = "Jenkins"
  }
}