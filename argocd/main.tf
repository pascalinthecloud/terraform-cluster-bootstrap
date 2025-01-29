resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_chart_version
  lint             = true
  namespace        = "argocd"
  create_namespace = true
  values = [
    templatefile("${path.module}/argocd.yaml", {
      host = var.argocd_host
    })
  ]
  set_sensitive = [{
    name  = "extraObjects[0]"
    value = <<EOT
apiVersion: v1
data:
  sops.asc: ${var.argocd_gpg_key}
kind: Secret
metadata:
  name: sops-gpg
type: Opaque
EOT
    type  = "auto"
  }]
}