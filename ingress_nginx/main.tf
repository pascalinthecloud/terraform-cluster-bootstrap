resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  namespace        = "ingress-nginx"
  version          = var.chart_version
  lint             = true
  create_namespace = true
  cleanup_on_fail  = true

  set = [{
    name  = "controller.kind"
    value = "DaemonSet"
    },
    {
      name  = "controller.ingressClassResource.default"
      value = "true"
  }]

}