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
  name       = "metallb"
  chart      = "metallb"
  repository = "https://metallb.github.io/metallb"
  namespace  = "metallb-system"
}
resource "kubectl_manifest" "ip_pool" {
  depends_on = [helm_release.metallb]
  yaml_body = templatefile("${path.module}/configs/ip_pool.yaml",
    {
      "ip_range" = var.ip_range
  })
}
resource "kubectl_manifest" "l2_advertisement" {
  depends_on = [helm_release.metallb]
  yaml_body  = file("${path.module}/configs/l2_advertisement.yaml")
}
