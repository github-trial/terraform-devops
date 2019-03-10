# terraform-devops

##The complete Terraform Structure....

1. Tree Strcture..

terraform-devops <br />
|__main.tf <br />
|__variable.tf
|__module/
|  |__vpc/
|  |  |__vpc.tf
|  |  |__variable.tf 
|  |__sg/
|  |  |__sg.tf
|  |  |__variable.tf
|  |__ec2/
|  |  |__ec2.tf
|  |  |__variable.tf
|__provisioner/
|  |__install.sh
|__README.md
