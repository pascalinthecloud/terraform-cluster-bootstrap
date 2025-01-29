module "mettallb" {
  source   = "./metallb"
  ip_range = var.ip_range
}

module "ingress_nginx" {
  source = "./ingress_nginx"
}

module "longhorn" {
  source = "./longhorn"
}

module "prometheus" {
  source = "./prometheus"
}

module "argocd" {
  source               = "./argocd"
  argocd_host          = var.argocd_host
  argocd_gpg_key       = var.argocd_gpg_key
  argocd_chart_version = var.argocd_chart_version
}