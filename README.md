# Enterprise Course Catalog: OPENLXP-SAMPLE

# OpenLXP - Infrastructure
This repository contains Terraform scripts to build/deploy the infrastructure to run the Enterprise Course Catalog XIA sample agent, Course Catalog and other sample components.

# Intended Use
This repository is intended for System Operators that would use Terraform scripts to deploy and administer the resources.

# Operating System Requirements
Terraform Enterprise currently supports running under the following operating systems:

* Debian 9 - 10
* Ubuntu 14.04.5 / 16.04 / 18.04 / 20.04
* Red Hat Enterprise Linux 7.4 - 7.9 / 8.4
* CentOS 7.4 - 7.9 / 8.4
* Amazon Linux 2014.03 / 2014.09 / 2015.03 / 2015.09 / 2016.03 / 2016.09 / 2017.03 / 2017.09 / 2018.03 / 2.0
* Oracle Linux 7.4 - 7.9 / 8.4

# Installing Terraform
If Terraform is not installed, run commands below (example shown for Ubuntu OS. For others, navigate here: https://learn.hashicorp.com/tutorials/terraform/install-cli)

Ensure that your system is up-to-date, and you have the gnupg, software-properties-common, and curl packages installed.
You will use these packages to verify HashiCorp's GPG signature, and install HashiCorp's Debian package repository. For more information on packages, refer to [FAQ](#FAQ)
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
```

Add the HashiCorp GPG Key:
```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

Add the official HashiCorp Linux repository:
```
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Update and Install Terraform:
```
sudo apt-get update && sudo apt-get install terraform
```

Verify:
```
terraform -help
```

# Using Terraform with AWS

On an EC2 instance with admin  (Latest Ubuntu used), clone the openlxp-sample repository:

```
git clone https://github.com/OpenLXP/openlxp-sample.git
```

Navigate to 'openlxp-xia-sample-terraform' directory. In locals.tf, line 2, update the value of 'my_pub_ip' with your public ip address in order to reach component endpoints after creation. 

Initialize Terraform and apply the build for the creation of sample xia/course catalog resources. The '-auto-approve' flag here bypasses the need to let terraform know you'd like to perform the apply action. 
```
cd openlxp-xia-sample-terraform
terraform init
terraform apply -auto-approve
```
Once your Terraform apply is complete, you can navigate over to the EC2 console and connect to the xia agent/course catalog instance via the endpoint


To build out the remaining Enterprise Course Catalog infrastructure, navigate to 'openlxp-infrastructure-terraform'
```
cd openlxp-infrastructure-terraform
terraform init
terraform apply -auto-approve
```

# Terraform

When existing Terraform templates have been modified or new templates are created, it is good practice to format the files. This can be done by running a simple format command.
```
terraform fmt
```

Now it is time to plan out the build using Terraform. Once templates are formatted and directory is initialize, Terraform is ready to plan its deployment. This is a crucial step before applying the templates into the environment. Terraform plan will run through all Terraform configuration templates and output a list of resources that will be launched. It will also output any errors that are identified in the templates whether it is syntax error, missing variables, spelling, etc.
```
terraform plan
```

When Terraform plan output looks as expected and any errors have been fixed, it is time to apply. It is important to understand what is being deployed and plan out the cost of resources being created. Terraform apply will run through the templates and output a list of resources to be created once more and have the system operator running the command confirm with a simple yes or no answer. When ready to deploy, enter yes and Terraform will work its magic and create an entire infrastructure or specified resources that have been defined in the Terraform templates.
```
terraform apply
```
# Troubleshooting

If you get an error that terraform could not be found, your PATH environment variable was not set up properly. Please go back and ensure that your PATH variable contains the directory where Terraform was installed.

If you're unable to connect to the endpoint, ensure your public ip address was added to local.tf before terraform apply was run. 

# FAQ

**Q: What is Terraform?**

**A:  Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. You can then use a consistent workflow to provision and manage all of your infrastructure throughout its lifecycle. Terraform can manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features. https://www.terraform.io/intro**

**Q: What cloud platform is the infrastructure built in?**

**A: In this repository, we are using Amazon Web Services but this can also be built in Azure. Please refer to: https://learn.hashicorp.com/tutorials/terraform/install-cli**


**Q: What is gnupg, software-properties-common, and curl packages installed?**

**A: GnuPG is free cryptographic software from the GNU Project which helps people ensure the confidentiality, integrity and assurance of their data. 
For more info: https://www.gnupg.org/faq/gnupg-faq.html?msclkid=2692147ba56211ec879b0ca7dd9ad005. Both software-properties-common and curl are packages required for the installation of Terraform.** 

