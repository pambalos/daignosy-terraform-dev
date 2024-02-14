terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

provider "google" {
  project = "multi-cloud-app-413619"
  region  = "asia-east2"
  credentials = "keys/multi-cloud-app-413619-e56533de070c.json"
}

provider "kubectl" {
  load_config_file = false
  host = "https://${google_container_cluster.primary.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  token = data.google_client_config.provider.access_token
}

data "google_client_config" "provider" {}

resource "kubectl_manifest" "diagnosy_manifest" {
  count = length(data.kubectl_filename_list.manifests.matches)
  yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
}

data "kubectl_filename_list" "manifests" {
  pattern = "./app/*.yaml"
}

# Variables
variable "project_id" {
  description = "The project ID"
}

variable "gcloud_region" {
    description = "The region to create resources in"
}

variable "node_machine_type" {
  description = "The machine type for the nodes"
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.gcloud_region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

# kubernetes


# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location = var.gcloud_region
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.gcloud_region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.gcloud_region
  cluster    = google_container_cluster.primary.name

  version = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = var.node_machine_type
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}