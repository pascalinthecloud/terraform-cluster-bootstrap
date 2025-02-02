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
    set = [
      for annotation, value in var.ingress_annotations : {
        name  = "ingress.annotations.${annotation}"
        value = value
      }
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
  namespace: argocd
type: Opaque
EOT
    type  = "auto"
  }]
}