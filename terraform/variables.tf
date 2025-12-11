variable "gcp_project" {
  type        = string
  default     = "projetsparkantoineloic"
}
variable "gcp_zone" {
  type        = string
  default     = "europe-west1-b"
}

variable "gcp_region" {
  type        = string
  default     = "europe-west1"
}

variable "ssh_user" {
  type        = string
  default     = "ubuntu"
}

variable "ssh_private_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "ssh_public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}