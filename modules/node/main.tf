data "aws_ssm_parameter" "ubuntu-focal" {
  name = "aws/service/canonical/ubuntu/server/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_instance" "node" {
  ami = data.aws_ssm_parameter.ubuntu-focal.value
  instance_type = var.instance_type
  subnet_id = var.subnet_public_id
  vpc_security_group_ids = [var.public_security_group_id]
  tags = {
    Name = format("%s-node", var.project)
  }
}