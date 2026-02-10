output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "frontend_sg_id" {
  value = aws_security_group.frontend.id
}

output "backend_sg_id" {
<<<<<<< HEAD
  value = aws_security_group.backend_fhs_sg.id
}
=======
  value = aws_security_group.backend.id
}
output "db_sg_id" {
  value = aws_security_group.database.id
}
>>>>>>> e7697c9 (Terraform v1)
