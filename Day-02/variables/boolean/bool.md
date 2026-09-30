

-----

### Terraform Data Type: `bool`  toggles 🔛/OFF

A `bool` (boolean) variable is a simple toggle. It can only have two possible values: **`true`** or **`false`**.

This data type is perfect for enabling or disabling resources, features, or specific configurations within your code.

-----

### 💻 Example: Toggling a Public IP Address

Let's use a `bool` variable to decide whether our EC2 instance should have a public IP address.

**1. Define the Variable (`variables.tf`)**

We declare our variable, set its `type` to `bool`, and give it a `default` value.

```terraform
variable "enable_public_ip" {
  description = "If true, assigns a public IP to the EC2 instance."
  type        = bool
  default     = true
}
```

**2. Use the Variable (`main.tf`)**

In our `aws_instance` resource, the `associate_public_ip_address` argument is waiting for a boolean. We pass our variable directly to it.

```terraform
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Example AMI
  instance_type = "t2.micro"
  
  # This line now reads 'true' from our variable
  associate_public_ip_address = var.enable_public_ip 
  
  tags = {
    Name = "My-Web-Server"
  }
}
```

**3. (Optional) Override the Value (`terraform.tfvars`)**

If you are deploying to a private environment where you don't want public IPs, you can easily turn this feature off in your `terraform.tfvars` file.

```hcl
# terraform.tfvars

enable_public_ip = false
```

Now, when you run `terraform apply`, the instance will be created *without* a public IP, and you didn't have to change your main code.

-----

### 💡 Common Use Cases for `bool`

  * **Feature Flags:** 🚩 `create_load_balancer = true`, `enable_monitoring = false`
  * **Controlling `count`:** A very common pattern for conditionally creating a resource.
      * `count = var.create_resource ? 1 : 0` (If `var.create_resource` is `true`, count is 1; if `false`, count is 0, and the resource is not created).
  * **Environment Toggles:** 🔒 `is_production_env = true`
  * **Enabling/Disabling Settings:** `delete_on_termination = true` for a disk.