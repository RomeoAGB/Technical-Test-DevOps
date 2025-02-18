//Write a Terraform configuration file
provider "google" {
  project = "miprimerproyecto-308719"
  region  = "us-central1"
}

//Creates a single-node Google Kubernetes Engine (GKE) cluster
provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.clusterP.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.clusterP.master_auth.0.cluster_ca_certificate)
}

data "google_client_config" "default" {}

data "google_container_cluster" "clusterP" {
  name     = google_container_cluster.clusterP.name
  location = google_container_cluster.clusterP.location
}

resource "google_container_cluster" "clusterP" {
  name     = "cluster-gke"
  location = "us-central1"

  initial_node_count       = 1
  remove_default_node_pool = true

  network    = "default"
  subnetwork = "default"
}

resource "google_container_node_pool" "nodoP" {
  name       = "pool-nodes"
  location   = "us-central1"
  cluster    = google_container_cluster.clusterP.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 20
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

//Deploys a simple Nginx container inside the cluster
resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "deploy-nginx"
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginxS" {
  metadata {
    name = "service-nginx"
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}