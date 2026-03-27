# modules/databricks-workspace/main.tf

# 1. Cross-account IAM Role for Databricks to manage resources
resource "aws_iam_role" "databricks_cross_account_role" {
  name               = "mia-volt-databricks-crossaccount"
  assume_role_policy = data.aws_iam_policy_document.databricks_assume_role.json
}

# 2. Storage Configuration (The Root S3 Bucket for Delta Lake)
resource "aws_s3_bucket" "databricks_storage" {
  bucket = "mia-volt-databricks-storage-${var.environment}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "databricks_storage_block" {
  bucket                  = aws_s3_bucket.databricks_storage.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 3. The Databricks Workspace
resource "databricks_mws_workspaces" "this" {
  account_id               = var.databricks_account_id
  aws_region               = var.region
  workspace_name           = "mia-volt-${var.environment}"
  deployment_name          = "mia-volt-${var.environment}"
  
  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id

  token {
    comment = "Terraform managed token for mia-ai-volt-streams"
  }
}
