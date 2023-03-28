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

resource "aws_ebs_volume" "data-vol" {
  availability_zone = var.availability_zone
  size = 1024
  type = "gp2"
  tags = {
    Name = format("%s-data-vol", var.project)
  }
}

resource "aws_volume_attachment" "data-vol-attach" {
  device_name = "/dev/sda1"
  volume_id = aws_ebs_volume.data-vol.id
  instance_id = aws_instance.node.id
}

resource "aws_eip" "node-eip" {
  vpc = true
  tags = {
    Name = format("%s-node-eip", var.project)
  }
}

resource "aws_eip_association" "eip-association" {
  instance_id = aws_instance.node.id
  allocation_id = aws_eip.node-eip.id
}