resource "aws_security_group" "allow_http" {
  name        = "assg-sg"
  description = "Allow TLS inbound traffic"

  ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["${data.aws_subnet.selected.cidr_block}"]
  }

  egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
  }

}


resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "assg-"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }

  security_groups = ["${aws_security_group.allow_http.id}"]

  user_data = "${data.local_file.app_server.content}"
}

resource "aws_autoscaling_group" "bar" {
  name                 = "terraform-asg-example"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  min_size             = 5
  max_size             = 5

  lifecycle {
    create_before_destroy = true
  }
  health_check_type = "ELB"
  load_balancers = ["${aws_elb.bar.id}"]
  vpc_zone_identifier = ["${var.subnet_id}"]
}
