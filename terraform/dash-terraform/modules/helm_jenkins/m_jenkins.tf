resource "kubernetes_namespace" "jenkins_namespace_resource" {
  metadata {
    # annotations = {
    #   name = "example-annotation"
    # }

    # labels = {
    #   mylabel = "label-value"
    # }

    name = "jenkins"
  }
}

resource "kubernetes_persistent_volume" "dash_jenkins_pv_resource" {
  metadata {
    name = "dash-jenkins-volume"
  }
  spec {
    storage_class_name = "standard"
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = "jenkins-home"
        fs_type = "ext4"
      }
    }
  }

  depends_on = [kubernetes_namespace.jenkins_namespace_resource]
}

resource "kubernetes_persistent_volume_claim" "dash_jenkins_pvc_resource" {
  metadata {
    name      = "dash-jenkins-pvc"
    namespace = "jenkins"
  }
  spec {
    storage_class_name = "standard"
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
    volume_name = "${kubernetes_persistent_volume.dash_jenkins_pv_resource.metadata.0.name}"
  }

  depends_on = [kubernetes_persistent_volume.dash_jenkins_pv_resource]
}

resource "helm_release" "jenkins-app-resource" {
  name      = "jenkins-cd"
  chart     = "stable/jenkins"
  namespace = "jenkins"

  provisioner "local-exec" {
    command = "sleep 30"
  }

  set {
    name  = "persistence.existingClaim"
    value = "dash-jenkins-pvc"
  }

  set {
    name  = "master.adminPassword"
    value = "itsanup"
  }

  depends_on = [kubernetes_persistent_volume_claim.dash_jenkins_pvc_resource]
}

