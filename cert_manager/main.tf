resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  namespace        = "cert-manager"
  version          = "1.16.3"
  create_namespace = true

  set = [{
    name  = "crds.enabled"
    value = "true"
    }
  ]
}

resource "kubectl_manifest" "cluster_issuer" {
  depends_on = [helm_release.cert_manager]

  yaml_body = templatefile("${path.module}/cluster_issuer.yaml", {
    EMAIL       = var.email
    ACME_SERVER = var.acme_server
  })
}
resource "kubectl_manifest" "secret" {
  depends_on = [helm_release.cert_manager]

  yaml_body = templatefile("${path.module}/secret_cloudflare_api_token.yaml", {
    CLOUDFLARE_API_TOKEN = var.cloudflare_api_token
  })
}