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
  host                   = "https://34.150.109.183"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUVMRENDQXBTZ0F3SUJBZ0lRTkMxOFEyWjdVNWRGa0p5TU13Z1FDekFOQmdrcWhraUc5dzBCQVFzRkFEQXYKTVMwd0t3WURWUVFERXlRM09EWmxNVFV6T1MwNVpHSXdMVFE1T1dFdFlXWXlOQzFrTURreE0ySmhOelkyTlRFdwpJQmNOTWpRd01qRTVNREkwTlRFeldoZ1BNakExTkRBeU1URXdNelExTVROYU1DOHhMVEFyQmdOVkJBTVRKRGM0Ck5tVXhOVE01TFRsa1lqQXRORGs1WVMxaFpqSTBMV1F3T1RFelltRTNOalkxTVRDQ0FhSXdEUVlKS29aSWh2Y04KQVFFQkJRQURnZ0dQQURDQ0FZb0NnZ0dCQU5MbTRCVlM1em9oZi9LL2pkaU5VOUVkeU10S3lrcXF4Nkt3eU5LOAoxMkdMRnZRSmRsMEVaSWlPTmNQK2hUbno2eS9aMllmemc3bHM2SGdoWlg1c1J2cVQ1ODhHaXo4R2V6cFhvM3dvCkJCWGFqWTFDalNvYzQyWGVRSjhhSjNMMmlqN2thOHJFT1BESzlBWnRBU3JPcGJXY1JSbzhpSGhUcXkydGV5aXkKdkFTQXhrWnBYcERUSkkxRzIwbUtFcDhvejA2OS8xaVYzU012NklQOTYvalU5Tnp1TUhsT2toTk9GY2haWFlCQQpnUjZveE0zV1ZFZnA1NzY4c2c3ZzBQK2JsSWlndndDQXBTSXpHUWJsNDhsOHpTUjZRM1ZsdnV1Q2htc3VxdkFiCk9kWGV5Q1VZeUN4MTdEVzNqdXFvK0pkMmVFeTM5ZDI1VWdkTGhwa3hRdkY0N3JrYlF2bDdRRVYxRjJlazhuQzkKQVMzWWNZaEZKN1l1aGpsWnFrYklIVTFNbFhHQVlRcmZNLzZlZFRPODJ2OG53Qmd2ZVp6eXl0T2h3UUtlMVMzbwpaanM5bmdDblp4ZDdpalVNUUF1NVdHOW8xc2l2RE12YjVPNENrYzVsV0pjc1YxWVRESndVWmN3RGNJYmkvRk91CkJ6eHRLcGdPTldwNTJuMGFKdjN3RTNXMFFRSURBUUFCbzBJd1FEQU9CZ05WSFE4QkFmOEVCQU1DQWdRd0R3WUQKVlIwVEFRSC9CQVV3QXdFQi96QWRCZ05WSFE0RUZnUVUySHJiaUZPVXRoU0d3MFJ0M0JHTjNKR2ZuSDh3RFFZSgpLb1pJaHZjTkFRRUxCUUFEZ2dHQkFITUlGRDVXMlJPSWVaa2Q5aHZzc3Fsa1R1UzVDMWFiV3RuMnFvdXN2U29YCndFUGs2Z2ptK0Q0U204NFp5YnZaNEgwYUpOZS84V0U3bFBSdHQ3aTFIWkRqNWt6TlkvNEt1QkZVVTR4b0ZsaUkKd1NaM2lXa21JS0h6bks0TGZYbWlkamk2VnIrOTVHR1pVWE02YjBXVk4yLytXc1JZbHhvaHFVSG5GMFI2SlFPbQpnUWEwd3pVMm9FUzRUVjhtRVdnbVVoQTNFdnRlcm5GWTBreEtIeFFlTHJnYitxWFZza1NXdTFvWmxlWWJqQndMClV4WklFTmRFdmM4WnozSFpnRFVhbTk3M1hueGdmQ3JwWVJabzFRek8zWmZsVDdINXI2dnVPM05raFQ5dVhEMmsKWGF2M2Y1ZHlmWittNW10SGZaYkVQN2Z1SGp4N253aWliREhVZDZjamJ4ZGxHOG4yeU04TGxOZEpJY0ZHTUhMNgptODFpTC9KNy90cU1RM21VdDl5Z21CZUttS1AvODhKdXUwamk1Y01ONUcrQjVaeDR4UkFzbHJaMWN3cEJYL2F1Ck1lalRNdG1rdTJKTm10R3Z0TGw1UVpHY2RiVlczK3lFb2h4VEhIbVNjZGUwa3VxbDdMakY3MzFzd2VVVVozaVAKVDJFaUQ2TmpPeEFrNHJxUkJyOHVpdz09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K")
}

provider "kubectl" {
  load_config_file = false
  host = "https://34.150.109.183"
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUVMRENDQXBTZ0F3SUJBZ0lRTkMxOFEyWjdVNWRGa0p5TU13Z1FDekFOQmdrcWhraUc5dzBCQVFzRkFEQXYKTVMwd0t3WURWUVFERXlRM09EWmxNVFV6T1MwNVpHSXdMVFE1T1dFdFlXWXlOQzFrTURreE0ySmhOelkyTlRFdwpJQmNOTWpRd01qRTVNREkwTlRFeldoZ1BNakExTkRBeU1URXdNelExTVROYU1DOHhMVEFyQmdOVkJBTVRKRGM0Ck5tVXhOVE01TFRsa1lqQXRORGs1WVMxaFpqSTBMV1F3T1RFelltRTNOalkxTVRDQ0FhSXdEUVlKS29aSWh2Y04KQVFFQkJRQURnZ0dQQURDQ0FZb0NnZ0dCQU5MbTRCVlM1em9oZi9LL2pkaU5VOUVkeU10S3lrcXF4Nkt3eU5LOAoxMkdMRnZRSmRsMEVaSWlPTmNQK2hUbno2eS9aMllmemc3bHM2SGdoWlg1c1J2cVQ1ODhHaXo4R2V6cFhvM3dvCkJCWGFqWTFDalNvYzQyWGVRSjhhSjNMMmlqN2thOHJFT1BESzlBWnRBU3JPcGJXY1JSbzhpSGhUcXkydGV5aXkKdkFTQXhrWnBYcERUSkkxRzIwbUtFcDhvejA2OS8xaVYzU012NklQOTYvalU5Tnp1TUhsT2toTk9GY2haWFlCQQpnUjZveE0zV1ZFZnA1NzY4c2c3ZzBQK2JsSWlndndDQXBTSXpHUWJsNDhsOHpTUjZRM1ZsdnV1Q2htc3VxdkFiCk9kWGV5Q1VZeUN4MTdEVzNqdXFvK0pkMmVFeTM5ZDI1VWdkTGhwa3hRdkY0N3JrYlF2bDdRRVYxRjJlazhuQzkKQVMzWWNZaEZKN1l1aGpsWnFrYklIVTFNbFhHQVlRcmZNLzZlZFRPODJ2OG53Qmd2ZVp6eXl0T2h3UUtlMVMzbwpaanM5bmdDblp4ZDdpalVNUUF1NVdHOW8xc2l2RE12YjVPNENrYzVsV0pjc1YxWVRESndVWmN3RGNJYmkvRk91CkJ6eHRLcGdPTldwNTJuMGFKdjN3RTNXMFFRSURBUUFCbzBJd1FEQU9CZ05WSFE4QkFmOEVCQU1DQWdRd0R3WUQKVlIwVEFRSC9CQVV3QXdFQi96QWRCZ05WSFE0RUZnUVUySHJiaUZPVXRoU0d3MFJ0M0JHTjNKR2ZuSDh3RFFZSgpLb1pJaHZjTkFRRUxCUUFEZ2dHQkFITUlGRDVXMlJPSWVaa2Q5aHZzc3Fsa1R1UzVDMWFiV3RuMnFvdXN2U29YCndFUGs2Z2ptK0Q0U204NFp5YnZaNEgwYUpOZS84V0U3bFBSdHQ3aTFIWkRqNWt6TlkvNEt1QkZVVTR4b0ZsaUkKd1NaM2lXa21JS0h6bks0TGZYbWlkamk2VnIrOTVHR1pVWE02YjBXVk4yLytXc1JZbHhvaHFVSG5GMFI2SlFPbQpnUWEwd3pVMm9FUzRUVjhtRVdnbVVoQTNFdnRlcm5GWTBreEtIeFFlTHJnYitxWFZza1NXdTFvWmxlWWJqQndMClV4WklFTmRFdmM4WnozSFpnRFVhbTk3M1hueGdmQ3JwWVJabzFRek8zWmZsVDdINXI2dnVPM05raFQ5dVhEMmsKWGF2M2Y1ZHlmWittNW10SGZaYkVQN2Z1SGp4N253aWliREhVZDZjamJ4ZGxHOG4yeU04TGxOZEpJY0ZHTUhMNgptODFpTC9KNy90cU1RM21VdDl5Z21CZUttS1AvODhKdXUwamk1Y01ONUcrQjVaeDR4UkFzbHJaMWN3cEJYL2F1Ck1lalRNdG1rdTJKTm10R3Z0TGw1UVpHY2RiVlczK3lFb2h4VEhIbVNjZGUwa3VxbDdMakY3MzFzd2VVVVozaVAKVDJFaUQ2TmpPeEFrNHJxUkJyOHVpdz09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K")
  token = data.google_client_config.provider.access_token
}

data "google_client_config" "provider" {}

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

