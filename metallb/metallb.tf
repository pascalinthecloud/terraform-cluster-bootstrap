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

resource "kubernetes_manifest" "ip_pool" {
  depends_on = [helm_release.metallb]
  manifest   = yamldecode(file("${path.module}/configs/ip_pool.yaml"))
}

resource "kubernetes_manifest" "l2_advertisement" {
  depends_on = [helm_release.metallb]
  manifest   = yamldecode(file("${path.module}/configs/l2_advertisement.yaml"))
}

