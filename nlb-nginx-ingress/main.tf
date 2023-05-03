
data "kubectl_path_documents" "docs" {
  pattern = "./manifests/*.yaml"
}

resource "kubectl_manifest" "test" {
  apply_only = data.kubectl_path_documents.docs.documents
#   for_each  = toset(data.kubectl_path_documents.docs.documents)
#   yaml_body = each.value
# #   depends_on = [
#     null_resource.kubectl,
#     module.eks
#   ]
}

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${var.eks_cluster_name}"
  }
#   depends_on = [module.eks]
}


#############################----PROVIDER-FILE-------###########################


terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
  # profile = ""
}
# Datasource: EKS Cluster Auth 
# Terraform Kubernetes Provider
provider "kubernetes" {
  config_path    = "C:/Users/what/.kube/config"
}
