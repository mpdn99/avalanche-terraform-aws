data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "node" {
  ami = data.aws_ami.ami.id
  instance_type = var.instance_type
  subnet_id = var.subnet_public_id
  vpc_security_group_ids = [var.public_security_group_id]
  tags = {
    Name = format("%s-node", var.project)
  }
}