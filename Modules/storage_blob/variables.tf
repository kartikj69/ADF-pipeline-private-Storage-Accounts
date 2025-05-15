variable "name" {
  description = "Name of the blob"
  type        = string
  default     = "sample.txt"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "stgdefault"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "data"
}

variable "type" {
  description = "Type of the blob (Block, Page, Append)"
  type        = string
  default     = "Block"
}

variable "source_path" {
  description = "Path to the source file"
  type        = string
  default     = null
}

variable "source_content" {
  description = "Content of the blob"
  type        = string
  default     = "This is a sample file content."
}

variable "content_type" {
  description = "Content type of the blob"
  type        = string
  default     = "text/plain"
}

variable "metadata" {
  description = "Metadata for the blob"
  type        = map(string)
  default     = {}
}
