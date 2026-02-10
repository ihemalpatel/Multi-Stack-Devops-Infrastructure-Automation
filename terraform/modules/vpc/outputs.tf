output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "frontend_sg_id" {
  value = aws_security_group.frontend_fhs_sg.id
}

output "backend_sg_id" {
  value = aws_security_group.backend_fhs_sg.id
}