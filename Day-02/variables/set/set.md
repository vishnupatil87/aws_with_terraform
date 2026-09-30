

-----

### Terraform Data Type: `set` 🛡️

A `set` variable is a collection of **unique values** that have **no specific order**.

Think of it as a `list` that automatically removes any duplicates and doesn't care about the order of items. This is useful when you need to provide a collection of items, but the uniqueness of each item is more important than the order they are in.

  * **List** 📋 = Ordered, allows duplicates.
  * **Set** 🛡️ = Unordered, **no duplicates**.

-----

### 💻 Example: Attaching Unique IAM Policies

Let's use a `set(string)` variable to define a list of IAM policy ARNs to attach to a user. If you accidentally list the same policy twice, a `set` will automatically de-duplicate it, preventing an error.

**1. Define the Variable (`variables.tf`)**

We declare our variable with `type = set(string)`. Notice the `default` value has a duplicate entry.

```terraform
variable "policy_arns" {
  description = "A set of unique IAM policy ARNs to attach to the user."
  type        = set(string)
  
  default = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/ReadOnlyAccess" # <-- This duplicate will be ignored
  ]
}
```

**2. Use the Variable (`main.tf`)**

Because sets are unordered, you **cannot** use `count` and an index (like `list[count.index]`). Instead, you **must** use the `for_each` meta-argument.

`for_each` will iterate over each unique item in the set.

```terraform
# First, create a user to attach policies to
resource "aws_iam_user" "example" {
  name = "example-user"
}

# Now, use for_each to loop over the SET
resource "aws_iam_user_policy_attachment" "attach" {
  # This loops over each unique string in var.policy_arns
  for_each = var.policy_arns

  user_name = aws_iam_user.example.name
  
  # 'each.value' refers to the current item in the loop
  policy_arn = each.value 
}
```

Terraform will see the 3 items in the `default` list, convert it to a `set` of 2 unique items, and `for_each` will run twice.

**3. (Optional) Override the Value (`terraform.tfvars`)**

You can provide a different set of policies for another environment.

```hcl
# terraform.tfvars

policy_arns = [
  "arn:aws:iam::aws:policy/AdministratorAccess"
]
```

-----

### 💡 Common Use Cases for `set`

  * **Using `for_each`:** A `set` is the perfect data type when you need to create multiple resources using `for_each`.
  * **IAM Policy Attachments:** 🔑 As shown above, ensuring you don't attach the same policy twice.
  * **Availability Zones:** Providing a list of AZs (e.g., `["us-east-1a", "us-east-1c"]`) to `for_each` to create subnets in.
  * **Security Groups:** Providing a unique set of security group IDs to associate with an instance.