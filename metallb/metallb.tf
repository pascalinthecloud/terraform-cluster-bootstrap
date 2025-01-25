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
  provider   = kubernetes.default
  manifest   = templatefile("${path.module}/configs/ip_pool.yaml", {
    ip_pool = var.ip_pool
  })
}

resource "kubernetes_manifest" "l2_advertisement" {
  depends_on = [helm_release.metallb]
  provider   = kubernetes.default
  manifest   = file("${path.module}/configs/l2_advertisement.yaml")
}

