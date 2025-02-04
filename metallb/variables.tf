variable "ip_range" {
  description = "The IP range to use for MetalLB"
  type        = string
}

variable "chart_version" {
  description = "The version of the Helm chart to use"
  type        = string
  default     = "0.14.9"
}