resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  namespace        = "ingress-nginx"
  version          = "4.12.0"
  create_namespace = true

  set = [{
    name  = "controller.kind"
    value = "DaemonSet"
    },
    {
      name  = "controller.ingressClassResource.default"
      value = "true"
  }]

}