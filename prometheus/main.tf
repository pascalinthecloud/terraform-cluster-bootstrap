resource "helm_release" "prometheus" {
  name             = "prometheus"
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  namespace        = "monitoring"
  version          = "68.3.0"
  create_namespace = true

  set = [{
    name  = "prometheus.service.type"
    value = "LoadBalancer"
    }
    ]

}