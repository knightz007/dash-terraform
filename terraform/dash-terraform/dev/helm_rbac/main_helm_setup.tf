provider "kubernetes" {
  host           = "https://${var.cluster_master_ip}"
  config_context = "gke_${var.project_name}_${var.provider_region}_${var.cluster_name}"
}

module "helm_rbac_setup" {
  source = "../../modules/helm_rbac"
}
