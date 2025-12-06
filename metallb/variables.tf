variable "chart_version" {
  description = "The version of the Helm chart to use"
  type        = string
  default     = "0.14.9"
}

variable "additional_manifests" {
  description = "Additional Kubernetes manifests to apply after MetalLB installation (e.g., IPAddressPool, L2Advertisement, BGPPeer)"
  type        = list(string)
  default     = []
}
