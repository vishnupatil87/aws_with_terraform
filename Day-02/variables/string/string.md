

-----

### Terraform Data Type: `string` 📜

A `string` variable is used to store text values. This can be a single word, a sentence, an ID, or any sequence of characters. It is the most common and fundamental variable type in Terraform.

-----

### 💻 Example: Setting an AWS EC2 Instance Type

Let's use a `string` variable to define the `instance_type` for our server.

**1. Define the Variable (`variables.tf`)**

Here, we declare our variable, give it a `type` of `string`, and provide a `description` and a `default` value.

```terraform
variable "instance_type" {
  description = "The size of the EC2 instance (e.g., t2.micro, t3.small)."
  type        = string
  default     = "t2.micro"
}
```

**2. Use the Variable (`main.tf`)**

In our main configuration, we reference the variable using the `var.instance_type` syntax. This avoids hardcoding `"t2.micro"` directly into the resource.

```terraform
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Example AMI
  instance_type = var.instance_type      # <-- Variable is used here

  tags = {
    Name = "My-Web-Server"
  }
}
```

**3. (Optional) Override the Value (`terraform.tfvars`)**

If you want to use a different instance type for a specific deployment (like "staging" or "production") without changing the code, you can create a `terraform.tfvars` file.

```hcl
# terraform.tfvars

instance_type = "t3.small"
```

When you run `terraform apply`, Terraform will automatically use `"t3.small"` instead of the `default` value.

-----

### 💡 Common Use Cases for `string`

You'll use `string` variables for all kinds of text-based values, such as:

  * 🏷️ **Resource Names & Tags:** `"production-database"`, `"Environment = "dev"`
  * 📍 **Region & Zone Names:** `"us-east-1"`, `"us-east-1a"`
  * 🆔 **Specific IDs:** `"ami-0abcdef123456"`, `"vpc-123456abc"`
  * 🛣️ **File Paths:** `"./my-script.sh"`
  * 🔑 **Database Usernames:** `"admin_user"` (Note: Use `sensitive = true` for passwords\!)