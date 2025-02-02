variable "argocd_host" {
  description = "The domain for the global configuration"
  type        = string
}

variable "argocd_gpg_key" {
  description = "The GPG key to use for SOPS"
  type        = string
}

variable "argocd_chart_version" {
  description = "The version of the ArgoCD Helm chart to use"
  type        = string
  default     = "7.7.21"
}
