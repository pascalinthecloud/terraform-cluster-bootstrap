variable "argocd_host" {
  description = "The domain for the global configuration"
  type        = string
}

variable "argocd_gpg_key" {
  description = "The GPG key to use for SOPS"
  type        = string
}

variable "chart_version" {
  description = "The version of the Helm chart to use"
  type        = string
  default     = "7.7.21"
}

variable "ingress_annotations" {
  description = "Annotations to apply to the Ingress"
  type        = map(string)
  default     = {}
}