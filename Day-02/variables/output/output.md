
-----

### Terraform Output Variables 📤

**Output variables** are how you get information *out* of your Terraform configuration after it has been deployed. They are like "return values" for your infrastructure.

You use them to display important information to the user (like an IP address or a server ID) or to pass data from one Terraform module to another.

-----

### 💻 Example: Getting a Server's Public IP and ID

Let's create an EC2 instance and then **output** its Public IP address and unique ID so we can use them.

**1. Define the Resource (`main.tf`)**

First, here is the server we are creating. This is the resource that *has* the data we want.

```terraform
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Example AMI
  instance_type = "t2.micro"

  tags = {
    Name = "My-Web-Server"
  }
}
```

**2. Define the Outputs (`outputs.tf`)**

It's a best practice to put your outputs in a separate `outputs.tf` file. We use the `value` argument to point to the resource attribute we want to export.

```terraform
output "instance_public_ip" {
  description = "The public IP address of the web server."
  value       = aws_instance.web_server.public_ip
}

output "instance_id" {
  description = "The unique ID of the web server instance."
  value       = aws_instance.web_server.id
}
```

**3. See the Values (After `terraform apply`)**

After you run `terraform apply`, Terraform will print these output values at the very end. You can also view them at any time using the `terraform output` command:

```bash
$ terraform output

Outputs:

instance_id = "i-0123456789abcdef0"
instance_public_ip = "54.123.45.67"
```

-----

### 🔒 Example: Hiding Sensitive Information

What if the output is a password or an API key? You can use the `sensitive` argument to hide it from the console.

```terraform
# A resource that creates a database password
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# The sensitive output
output "database_password" {
  description = "The root password for the RDS database."
  value       = random_password.db_password.result
  sensitive   = true # <-- This hides the value
}
```

Now, when you run `terraform output`, you won't see the password:

```bash
$ terraform output

Outputs:

database_password = <sensitive>
```

-----

### 💡 Common Use Cases for `output`

  * **Connectivity:** 🌐 Displaying IP addresses, DNS names, or endpoint URLs.
  * **Resource IDs:** 🆔 Exporting unique IDs (like VPC IDs, Subnet IDs, Instance IDs) to be used by other systems.
  * **Module-to-Module:** 🚀 Passing data from a *child module* (like a VPC module) up to a *parent module* (e.g., outputting the VPC ID so the parent can create servers *in* it).
  * **Automation:** 🤖 Allowing external scripts (like Bash or Python) to query the `terraform output -json` command and use the values to configure an application.