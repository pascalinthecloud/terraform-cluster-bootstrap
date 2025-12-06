resource "kubectl_manifest" "namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: metallb-system
  labels:
    pod-security.kubernetes.io/enforce: privileged
    pod-security.kubernetes.io/audit: privileged
    pod-security.kubernetes.io/warn: privileged
YAML
}
resource "helm_release" "metallb" {
  depends_on = [kubectl_manifest.namespace]

  name            = "metallb"
  chart           = "metallb"
  repository      = "https://metallb.github.io/metallb"
  namespace       = "metallb-system"
  version         = var.chart_version
  lint            = true
  cleanup_on_fail = true
}

# wait 30 seconds for crd to come available
resource "time_sleep" "wait_30_seconds" {
  depends_on = [helm_release.metallb]

  create_duration = "30s"
}

resource "kubectl_manifest" "additional" {
  for_each = { for idx, manifest in var.additional_manifests : idx => manifest }

  depends_on = [time_sleep.wait_30_seconds]

  yaml_body = each.value
}
