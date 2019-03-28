##creating ec2 VM
resource "aws_key_pair" "github_trial" {
  key_name = "github-trial"
  public_key = "${file("/Users/greg/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "ec2_vm" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.github_trial.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  subnet_id    = "${var.subnet_id}"
  associate_public_ip_address = "true"
  tags = {
    value = "assign-test-vm"
  }

provisioner "file" {
  source = "../../provisioner/install.sh"
  destination = "/tmp/install.sh"


connection {
    type ="ssh"
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${var.key}"
    host	= "${element(module.ec2_vm.public_ip,count.index )}"
#    agent = true
    timeout  = "2m" 
 }
}
provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/install.sh",
    "sudo /tmp/install.sh"
  ]
 }
}

##create and allocate eip....
resource "aws_eip" "assign" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.ec2_vm.id}"
  allocation_id = "${aws_eip.assign.id}"
}

##ebs volume....
resource "aws_ebs_volume" "ebs-volume-add" {
    availability_zone = "eu-west-1a"
    size = 20
    type = "gp2" 
    tags {
        Name = "extra volume data"
    }
}

resource "aws_volume_attachment" "ebs-volume-add-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.ebs-volume-add.id}"
  instance_id = "${aws_instance.ec2_vm.id}"
}

output "instance-id" {
value = "${aws_instance.ec2_vm.id}"
}

output "eip" {
value = "${aws_eip.assign.public_ip}"
}
output "vol-id" {
value = "${aws_ebs_volume.ebs-volume-add.id}"
}
