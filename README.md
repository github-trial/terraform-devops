# terraform-devops

##The complete Terraform Structure....

1. Tree Strcture..

terraform-devops <br />
|------   main.tf <br />
|------   variable.tf <br />
|------   module/ <br />
|      |------   vpc/ <br />
|      |      |------   vpc.tf <br />
|      |      |------   variable.tf <br />
|      |------    sg/ <br />
|      |      |------   sg.tf <br />
|      |      |------   variable.tf <br />
|      |------    ec2/ <br />
|      |      |------   ec2.tf <br />
|      |      |------   variable.tf <br />
|------   provisioner/ <br />
|      |      |------   install.sh <br />
|------   output.tf <br />
|------   README.md <br />

Module VPC:   <br />
module vpc creates the complete network and outputs the vale of created resources.  <br />
Module SG:  <br />
module sg creates a Security Group with SSH rule configured and sits on the VPC created in the previous module (refered the output of vpc_id) <br />
Module EC2  <br />
Created ec2 VM with eip and volume attached to it and calls a privisioner which installs vanilla version of cicd tool Jenkins  <br />

2. output.tf is used to display all the out values exported in the above modules.
3. Each module has its outputs in the .tf file ( which can be added in a separate output.tf file in the respective modules "optional" )
