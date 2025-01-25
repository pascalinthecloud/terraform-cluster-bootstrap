resource "kubernetes_namespace" "metallb_system" {
  metadata {
    name = "metallb-system"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
      "pod-security.kubernetes.io/audit"   = "privileged"
      "pod-security.kubernetes.io/warn"    = "privileged"
    }
  }
}
resource "helm_release" "metallb" {
  depends_on = [kubernetes_namespace.metallb_system]
  name       = "metallb"
  chart      = "metallb"
  repository = "https://metallb.github.io/metallb"
  namespace  = "metallb-system"
}

resource "kubernetes_manifest" "ip_pool" {
  depends_on = [helm_release.metallb]
  manifest   = file("${path.module}/configs/ip_pool.yaml")
}

resource "kubernetes_manifest" "l2_advertisement" {
  depends_on = [helm_release.metallb]
  manifest   = file("${path.module}/configs/l2_advertisement.yaml")
}

