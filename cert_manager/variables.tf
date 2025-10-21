variable "email" {
  description = "Cloudflare email address"
  type        = string
}

variable "acme_server" {
  description = "ACME server URL"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}
