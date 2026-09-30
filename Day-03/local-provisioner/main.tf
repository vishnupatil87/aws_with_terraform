

# resource "aws_key_pair" "fctp_self_managed_key" {
#   key_name   = var.key_name
#   public_key = file("C:\\aws_with_terraform_july_batch\\Day-03\\ssh.pub")
# }

resource "aws_key_pair" "custom_key" {
  key_name   = "custom-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOdE8iK+ztBHGXMlcSi0fP48vhNLeHir/i2jsGT5Yb7N admin@DESKTOP-A6R6UMM"
}


resource "aws_instance" "example" {
  ami           = var.instance_ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  # count = var.instance_count
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = [aws_security_group.day_03_sg.id]
  key_name = aws_key_pair.custom_key.key_name

  provisioner "local-exec" {
    command = "echo The instance ${self.public_ip} is now running >> instance_info.txt"
  }


  tags = {
    Name = "${var.environment}-web-server"
    Environment = var.environment
  }
}


