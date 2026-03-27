# modules/databricks-workspace/network.tf

resource "databricks_mws_networks" "this" {
  account_id         = var.databricks_account_id
  network_name       = "mia-volt-network-${var.environment}"
  security_group_ids = [var.security_group_id]
  subnet_ids         = var.private_subnet_ids
  vpc_id             = var.vpc_id
}
