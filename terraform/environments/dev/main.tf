# 1. Existing Networking (The Foundation)
module "networking" {
  source = "../../modules/networking"
  # ... existing networking vars
}

# 2. Add: The Security Data Diode (PrivateLink)
module "privatelink" {
  source = "../../modules/aws-privatelink"

  vpc_id                  = module.networking.vpc_id
  region                  = "us-east-1"
  ot_gateway_cidr         = "10.0.1.0/24"
  private_subnet_ids      = module.networking.private_subnets
  private_route_table_ids = [module.networking.private_route_table_id]
}

# 3. Add: The Compute Engine (Databricks Workspace)
module "databricks_workspace" {
  source = "../../modules/databricks-workspace"

  environment           = "dev"
  databricks_account_id = var.databricks_account_id
  vpc_id                = module.networking.vpc_id
  private_subnet_ids    = module.networking.private_subnets
  # Reuse the security group from the privatelink module to ensure connectivity
  security_group_id     = module.privatelink.vpc_endpoint_sg_id
}