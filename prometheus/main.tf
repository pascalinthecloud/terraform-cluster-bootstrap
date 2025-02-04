resource "kubectl_manifest" "namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
  labels:
    pod-security.kubernetes.io/enforce: privileged
YAML
}
resource "helm_release" "prometheus" {
  depends_on      = [kubectl_manifest.namespace]
  name            = "prometheus"
  chart           = "kube-prometheus-stack"
  repository      = "https://prometheus-community.github.io/helm-charts"
  namespace       = "monitoring"
  version         = var.chart_version
  lint            = true
  cleanup_on_fail = true
  set = [{
    name  = "prometheus.service.type"
    value = "LoadBalancer"
    }
  ]

}