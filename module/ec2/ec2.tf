##creating ec2 VM
resource "aws_instance" "ec2_vm" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${var.key}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  subnet_id    = "${var.subnet_id}"
  associate_public_ip_address = "true"
  tags = {
    value = "assign-test-vm"
  }

provisioner "file" {
  source = "./provisioner/install.sh"
  destination = "/tmp/install.sh"
}

#connection {
#    type ="ssh"
#    user = "${var.INSTANCE_USERNAME}"
#    host        = "${element(aws_eip.assign.*.public_ip, 0)}"
#    #private_key = "${"file("${var.PATH_TO_PRIVATE_KEY}")"}
#    #private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
#    private_key = "${file(var.PATH_TO_PRIVATE_KEY)}"
#    timeout  = "1m" 
#}

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
