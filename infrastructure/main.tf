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
  }
  required_version = ">=1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

provider "google" {
  project = "multi-cloud-app-413619"
  region  = "asia-east2"
  credentials = "../keys/multi-cloud-app-413619-e56533de070c.json"
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

data "google_client_config" "provider" {}

# Variables
variable "project_id" {
  description = "The project ID"
}

variable "project_name" {}

variable "gcloud_region" {
    description = "The region to create resources in"
}

variable "node_machine_type" {
  description = "The machine type for the nodes"
}

variable "service_account_email" {
  description = "The email of the service account to use for the GKE nodes"
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_name}-subnet"
  region        = var.gcloud_region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_project_iam_member" "artifact_role" {
  role = "roles/artifactregistry.reader"
  member  = "serviceAccount:diagnosy-account@multi-cloud-app-413619.iam.gserviceaccount.com"
  project = var.project_id
}

# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location = var.gcloud_region
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name     = "${var.project_name}-gke"
  location = var.gcloud_region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name


  node_config {

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    service_account = var.service_account_email
  }
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
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    labels = {
      env = var.project_name
    }

    # preemptible  = true
    machine_type = var.node_machine_type
    tags         = ["gke-node", "${var.project_name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}