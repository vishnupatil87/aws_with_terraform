

-----

### Terraform Data Type: `list` 📋

A `list` variable is an **ordered collection of values**. It's like a shopping list where the order matters and you can have duplicate items. All values within a single list must be of the same type (e.g., a list of strings, a list of numbers).

Lists are extremely powerful when you need to create *multiple* resources based on a collection of items.

-----

### 💻 Example: Creating Multiple IAM Users

Let's use a `list(string)` variable to create several IAM users at once.

**1. Define the Variable (`variables.tf`)**

We declare our variable with `type = list(string)` and provide a `default` list of usernames.

```terraform
variable "user_names" {
  description = "A list of IAM usernames to create."
  type        = list(string)
  
  default = ["gaurav", "alice", "bob"]
}
```

**2. Use the Variable (`main.tf`)**

To create one resource for *each item* in the list, we combine the `count` meta-argument with the `length()` function.

  * `count = length(var.user_names)`: This tells Terraform, "The number of resources to create is equal to the number of items in the `user_names` list."
  * `var.user_names[count.index]`: We use the `count.index` (which goes 0, 1, 2...) to pick the corresponding item from our list.

<!-- end list -->

```terraform
resource "aws_iam_user" "team" {
  # Create one user for each name in the list (length = 3)
  count = length(var.user_names) 

  # Get the username at the current index (0, then 1, then 2)
  name = var.user_names[count.index] 
}
```

**3. (Optional) Override the Value (`terraform.tfvars`)**

If you need to create a different set of users for another environment, just redefine the list in your `terraform.tfvars` file.

```hcl
# terraform.tfvars

user_names = ["prod_admin", "prod_readonly_user"]
```

-----

### 💡 Common Use Cases for `list`

  * 🌍 **Creating Subnets:** Defining a list of CIDR blocks for subnets (e.g., `["10.0.1.0/24", "10.0.2.0/24"]`).
  * 🔒 **Security Group Ports:** Providing a list of ports to open (e.g., `[80, 443, 22]`).
  * 👥 **Managing Multiple Resources:** Creating multiple IAM users, S3 buckets, or anything where you need more than one copy based on a list of inputs.
  * 📍 **Availability Zones:** Passing a list of zones to spread resources across (e.g., `["us-east-1a", "us-east-1b"]`).