output "public_ip" {
    description = "this for the aws ec2 instace public ip"
    value = aws_instance.example.public_ip
  
}

output "private_ip" {
    description = "this for the aws ec2 instace private ip"
    value = aws_instance.example.private_ip
  
}

output "public_dns" {
    description = "this for the aws ec2 instace public dns"
    value = aws_instance.example.public_dns
  
}


output "private_dns" {
    description = "this for the aws ec2 instace private dns"
    value = aws_instance.example.private_dns
  
}

output "instance_id" {
    description = "this for the aws ec2 instace private dns"
    value = aws_instance.example.id
  
}