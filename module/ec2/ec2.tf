##creating ec2 VM
resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "ec2_vm" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  #key_name = "${var.key}"
  key_name = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  subnet_id    = "${var.subnet_id}"
  tags = {
    value = "assign-test-vm"
  }

provisioner "file" {
  source = "install.sh"
  destination = "../provisioner/install.sh"
}

provisioner "remote-exec" {
  inline = [
    "chmod +x ../provisioner/install.sh",
    "sudo ../provisioner/install.sh"
  ]
}

connnection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

resource "aws_eip" "assign" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.ec2_vm.id}"
  allocation_id = "${aws_eip.assign.id}"
}

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
