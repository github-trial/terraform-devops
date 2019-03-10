resource "aws_security_group" "allow_ssh" {
  vpc_id      = "${var.vpc_id}"
  name	      = "allow_ssh"
  ingress {
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port   = 22
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## export value
output "sg-id" {
  value       = "${aws_security_group.allow_ssh.id}"
}
