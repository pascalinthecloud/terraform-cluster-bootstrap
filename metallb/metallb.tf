resource "helm_release" "metallb" {
  name       = "metallb"
  chart      = "metallb"
  repository = "https://metallb.github.io/metallb"
  namespace  = "metallb-system"

  create_namespace = true

  values = [
    
  ]
}