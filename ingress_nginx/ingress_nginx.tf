resource "helm_release" "ingress_nginx" {
  name       = "ingress_nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = "ingress-nginx"

  create_namespace = true

  set {
    name  = "controller.kind"
    value = "DaemonSet"
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }
}