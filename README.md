
# Azure Terraform Infrastructure for a Linux Virtual Machine

This Terraform configuration deploys an Azure Linux Virtual Machine (VM) within it. The VM is set up with a public IP address and specific network security group (NSG) rules to allow SSH (port 22) and HTTP (port 8080) traffic. Additionally, Docker is installed on the VM, and an NGINX container is started.

![linux_vm_docker_tf](https://github.com/MrRfifa/Azure-Linux-VM-Deployment-Terraform/assets/101003527/61ad99dd-5386-4e2d-b26e-b115eeb08fc1)

## Table of Contents

- [Prerequisites](#prerequisites)
- [Files](#files)
- [Usage](#usage)
- [Accessing Deployed Resources](#accessing-deployed-resources)
- [Screenshots](#screenshots)
## Prerequisites

Before running this Terraform configuration, ensure that you have the following prerequisites:

- Azure CLI installed and authenticated.
- Terraform installed on your local machine.

# Files

- `main.tf`: Defines the Azure resources, such as the Virtual Machine, Virtual Network, Subnet, Public IP Address, Network Security Group, and security rules.

- `terraform.tfvars`: Defines variables used in the configuration, including the environment prefix, VM credentials, and more.

- `docker.sh`: The user data script that runs Docker installation and starts an NGINX container on the VM.
## Usage

1. **Clone this repository** to your local machine:

    ```bash
    git clone https://github.com/MrRfifa/Azure-Linux-VM-Deployment-Terraform.git
    ```

2. **Navigate to the cloned directory**:

    ```bash
    cd Azure-Linux-VM-Deployment-Terraform
    ```

3. **Generate an SSH Key Pair**:

  To generate an SSH key pair for authentication, follow these steps:

  - Open a terminal or command prompt on your local machine.

  - Run the following command to generate an SSH key pair with RSA encryption and a key size of 2048 bits:

  ```bash
    ssh-keygen -t rsa -b 2048 -f my_key
  ```

  This command will create two files, `my_key` (private key) and `my_key.pub` (public key), in the current directory.

  - The best practice is to move the key pair to the .ssh folder, which is typically located in your user's home directory.

4. **Customize the Terraform variables**:

   Open the `terraform.tfvars` file and adjust the variable values to match your desired configuration. Provide values for variables such as `vn_cidr_block`, `subnet_cidr_block`, `env_prefix`, and `vm_credentials` as needed. This file allows you to customize the settings before deploying your Azure infrastructure.

   Example `terraform.tfvars`:

   ```hcl
   vn_cidr_block     = "10.0.0.0/16"
   subnet_cidr_block = "10.0.50.0/24"
   env_prefix        = "dev"
   vm_credentials = {
     username           = "your_username"
     ssh_file_location  = "/path/to/your/ssh_key.pub"
   }
   ```

5. **Initialize Terraform by running**:

    ```bash
    terraform init
    ```

6. **Review the plan to ensure everything is set up correctly:**:
      ```bash
    terraform plan
    ```
7. **Apply the configuration to create the Azure resources**:

      ```bash
    terraform apply
    ```
## Accessing deployed resources

After the deployment is complete, you can access the Linux VM and the NGINX application as follows:

- **Access the Linux VM via SSH**:

     Use the public IP address provided in the Terraform output to SSH into the VM. Replace `<username>` with the username you specified in your `terraform.tfvars` file and `<ip_addr>` with the actual public IP address:

     ```shell
     ssh -i path/to/my_key <username>@<ip_addr>
     ```

     This command will authenticate you with the SSH private key (`my_key`) and allow you to access the Linux VM.

- **Access the NGINX Application**:

     You can access the NGINX web server by opening a web browser and navigating to the following URL:

     ```
     http://<ip_addr>:8080
     ```

     Replace `<ip_addr>` with the public IP address of your VM. This URL will take you to the NGINX welcome page, indicating that the NGINX application is running successfully.


## Screenshots

### Deployment Result
![Deployment Result](https://github.com/MrRfifa/Azure-Linux-VM-Deployment-Terraform/assets/101003527/eb1d18ed-c380-426a-9c8a-8b4b296c8759)

The screenshot above shows the result of the Terraform deployment, indicating the successful creation of Azure resources.

### Azure Resources
![Azure Resources](https://github.com/MrRfifa/Azure-Linux-VM-Deployment-Terraform/assets/101003527/1db2bdf4-ed36-4388-a2d3-40bca235a3a3)

This screenshot displays the Azure resources created as part of the deployment, including the virtual machine, network components, and more.

### NGINX Web Page
![NGINX Web Page](https://github.com/MrRfifa/Azure-Linux-VM-Deployment-Terraform/assets/101003527/d4b77af7-49f3-4a50-a383-6db978803f1b)

Accessing the NGINX web page via the public IP address, you should see the NGINX welcome page, confirming that the web server is successfully running on the deployed virtual machine.

