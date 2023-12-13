# ACS730-Group1-Project



SENECA
Final Project: Two-Tier web application automation with Terraform, Ansible and GitHub Actions
Cloud Automation and Control Systems
ACS730NAA.06580.2237
Professor: Dhana Karuppusamy
 
Overview
    •	The project focuses on the deployment of a two-tier static web app via Terraform, ansible, and GitHub actions.
    •	We do terraform configurations, ansible-playbook, and GitHub actions for automation.
    •	We built an architecture that provisions 6VMs across public and private subnets which deploys webservers using s3 buckets and Ansible playbook for management.

Learning Outcomes
    •	The advantages of DevOps practices and deployment of automation, shifting towards the DevOps culture.
    •	Design automated deployment
    •	We will learn to analyze the functional and operational requirements of web applications.
    •	We will learn to implement infrastructure as code to deploy the entire application hosting solution.
    •	We will learn to apply security measures by implementing preventive and detective security controls. 

Steps:
    i.	Login to your GitHub account 
    ii.	Open the link https://github.com/elvishkarki/Group1-ACS730-FinalProject 
    iii.	You will see a green box with a code dropdown
    iv.	Use the command git clone https://github.com/elvishkarki/Group1-ACS730-FinalProject.git
    v.	Create an S3 bucket from the AWS portal with the same name as a config file.
    vi.	Check the name of S3 bucket from Group1-ACS730-FinalProject -> Production -> Network -> config.tf (from here we can find the name of the s3 bucket) 
    vii.	Create SSH key pair with the command:
    ssh-keygen -f /home/ec2-user/.ssh/Group1Key
    viii.	The next step is to deploy the infrastructure in production. Here we will be using terraform code.
    ix.	Now navigate to the respective folders based on the configuration you want to deploy. For example, to deploy in Production navigate to Production -> network, then deploy networking first and then webserver.
    x.	Commands to deploy:
        cd Group1-ACS730-FinalProject/Production/Network
        terraform init
        terraform fmt
        terraform validate
        terraform plan
        terraform apply –auto-approve
    xi.	After the deployment of the network part, we have to deploy a webserver.
    Run this code to deploy Webserver.
        Cd ../Webserver
        terraform init
        terraform fmt
        terraform validate
        terraform plan
        terraform apply –auto-approve
    xii.	Now the infrastructure is deployed.
    xiii.	Now will make one Webserver into Bastion through a ssh connection to Bastion. Use the command below:
    ssh -i ec2-user@bastion-host-public-ip
    xiv.	Now permit with the key to your Bastion host by copying RSA of our private key to Bastion instance.
    xv.	Now the final step is to delete the resources i.e., we now need to delete all the webservers and network. The webserver components should be deleted first before deleting the network or else we will be getting errors, or a few components will not be deleted and may increase the charge.
    Codes:
        cd Production/webserver
        terraform destroy –auto-approve
        After the deletion of a webserver 
        cd ../network
        terraform destroy –auto-approve

 
TEAM MEMBERS:
ELVISH KARKI
ROSHAN BOT
PRASON GIRI
ADARSH SHARMA
REVATHY SELVERAJ

