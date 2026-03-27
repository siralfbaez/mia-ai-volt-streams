variable "databricks_account_id" {
  description = "The unique ID for your Databricks account (found in the Databricks Account Console)"
  type        = string
  sensitive   = true # Marking as sensitive so it doesn't leak in CI/CD logs
}
