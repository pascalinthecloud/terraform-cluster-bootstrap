resource "kubernetes_namespace" "longhorn" {
  metadata {
    name = "longhorn"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}
resource "helm_release" "longhorn" {
  depends_on = [kubernetes_namespace.longhorn]
  name       = "longhorn"
  chart      = "longhorn"
  repository = "https://charts.longhorn.io"
  namespace  = "longhorn-system"

  version = "1.7.2"
}

