resource "kubectl_manifest" "namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: longhorn-system
  labels:
    pod-security.kubernetes.io/enforce: privileged
YAML
}

resource "helm_release" "longhorn" {
  depends_on      = [kubectl_manifest.namespace]
  name            = "longhorn"
  chart           = "longhorn"
  repository      = "https://charts.longhorn.io"
  namespace       = "longhorn-system"
  version         = var.chart_version
  lint            = true
  cleanup_on_fail = true
  set = [{
    name  = "service.ui.type"
    value = "LoadBalancer"
    },
    {
      name  = "service.manager.type"
      value = "LoadBalancer"
  }]
}

