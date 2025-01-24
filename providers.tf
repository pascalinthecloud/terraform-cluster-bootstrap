terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
}

provider "kubernetes" {
  host                   = var.host
  cluster_ca_certificate = var.ca_cert
  client_key             = var.client_key
  client_certificate     = var.client_cert
}