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