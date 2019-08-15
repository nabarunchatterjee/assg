data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]

}

data "local_file" "app_server" {
    filename = "configure.sh"
}



data "aws_subnet" "selected" {
  id = "${var.subnet_id}"

}

data "aws_region" "current" {}