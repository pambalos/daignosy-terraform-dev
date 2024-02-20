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

provider "kubernetes" {
  host                   = "https://${var.cluster_host}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "kubectl" {
  load_config_file = false
  host = "https://${var.cluster_host}"
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  token = data.google_client_config.provider.access_token
}

data "google_client_config" "provider" {}

# Variables
variable "project_id" {
  description = "The project ID"
}

variable "cluster_host" {
    description = "The host of the GKE cluster"
}

variable "cluster_ca_certificate" {
    description = "The CA certificate of the GKE cluster"
}

variable "gcloud_region" {
    description = "The region to create resources in"
}

variable "node_machine_type" {
  description = "The machine type for the nodes"
}

data "kubectl_filename_list" "manifests" {
  pattern = "./app/*.yaml"
}

variable "service_account_email" {
  description = "The email of the service account to use for the GKE nodes"
}

resource "kubectl_manifest" "diagnosy_manifest" {
  count = length(data.kubectl_filename_list.manifests.matches)
  yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
}

#resource "google_compute_disk" "persistent_disk" {
#  name  = "diagnosy-disk"
#  type  = "pd-ssd"
#  zone  = "asia-east2-a"
#  labels = {
#    environment = "diagnosy"
#  }
#  physical_block_size_bytes = 4096
#}

