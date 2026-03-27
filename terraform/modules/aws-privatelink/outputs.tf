output "vpc_endpoint_sg_id" {
  description = "The ID of the Security Group for VPC Endpoints"
  value       = aws_security_group.vpc_endpoint_sg.id
}
