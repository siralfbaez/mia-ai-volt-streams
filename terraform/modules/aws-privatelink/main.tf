# modules/aws-privatelink/main.tf

resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "mia-volt-vpce-sg"
  description = "Allow inbound traffic from OT Integration Gateway"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9094 # Kafka TLS
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = [var.ot_gateway_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Interface Endpoint for Amazon MSK (Kafka)
resource "aws_vpc_endpoint" "msk_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.kafka"
  vpc_endpoint_type = "Interface"

  security_group_ids = [aws_security_group.vpc_endpoint_sg.id]
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  tags = {
    Name = "mia-volt-msk-privatelink"
    Project = "mia-ai-volt-streams"
  }
}

# Gateway Endpoint for S3 (Delta Lake Storage)
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids

  tags = {
    Name = "mia-volt-s3-endpoint"
  }
}
