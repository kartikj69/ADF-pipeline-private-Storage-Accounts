locals {
  common_tags = merge(
    var.tags,
    {
      Environment = "Production"
      Terraform   = "True"
    }
  )

  # DNS zone references removed
  source_path = "${var.storage_accounts[0].container_name}"
  destination_path = "${var.storage_accounts[1].container_name}"
  # Source file for data transfer
  source_file_name = "sample.txt"
  source_file_content = "This is a sample file for ADF data transfer demonstration."
}
