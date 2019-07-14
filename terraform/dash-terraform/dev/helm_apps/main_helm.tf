provider "helm" {
  kubernetes {
    host = "https://${var.cluster_master_ip}"
  }
  install_tiller  = true
  service_account = "tiller"
  namespace       = "kube-system"
}

module "helm-jenkins" {
  source = "../../modules/helm_jenkins"
}
