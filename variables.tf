variable "ip_range" {
  description = "The IP range to use for MetalLB"
  type        = string
}

variable "client_key" {
  description = "The client key for the Kubernetes cluster"
  type        = string
}

variable "client_cert" {
  description = "The client certificate for the Kubernetes cluster"
  type        = string
}

variable "ca_cert" {
  description = "The CA certificate for the Kubernetes cluster"
  type        = string
}

variable "host" {
  description = "The host for the Kubernetes cluster"
  type        = string
}