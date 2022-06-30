data "spectrocloud_cluster_profile" "profile" {
  name = var.sc_cp_profile_name
  version = var.sc_cp_profile_version
}


resource "spectrocloud_cluster_aws" "cluster" {
  name               = var.sc_cluster_name
  cluster_profile {
   id = data.spectrocloud_cluster_profile.profile.id
  }
  #for newly created cloud account
  cloud_account_id   = spectrocloud_cloudaccount_aws.account.id
  
  #for existing cloud account
  #cloud_account_id   = data.spectrocloud_cloudaccount_aws.account.id
  
  cloud_config {
    ssh_key_name = var.aws_ssh_key_name
    region       = var.aws_region
  }

  # To override or specify values for a cluster:

  # pack {
  #   name   = "spectro-byo-manifest"
  #   tag    = "1.0.x"
  #   values = <<-EOT
  #     manifests:
  #       byo-manifest:
  #         contents: |
  #           # Add manifests here
  #           apiVersion: v1
  #           kind: Namespace
  #           metadata:
  #             labels:
  #               app: wordpress
  #               app2: wordpress2
  #             name: wordpress
  #   EOT
  # }

  machine_pool {
    control_plane           = true
    control_plane_as_worker = false
    name                    = "master-pool"
    count                   = var.master-pool_node_count
    instance_type           = var.master_instance_type
    disk_size_gb            = 62
    azs                     = var.master_aws_region_az
  }

  machine_pool {
    name          = "worker-pool01"
    count         = var.worker-pool_node_count
    instance_type = var.worker_instance_type
    disk_size_gb  = 62
    azs           = var.worker_aws_region_az
  }

}

#############
#adding new cluster for demo

data "spectrocloud_cluster_profile" "profile2" {
  name = "dev-team-2"
  version = var.sc_cp_profile_version
}

resource "spectrocloud_cluster_aws" "cluster2" {
  name               = "devtm2-cluster01"
  cluster_profile {
   id = data.spectrocloud_cluster_profile.profile2.id
  }
  #for newly created cloud account
  cloud_account_id   = spectrocloud_cloudaccount_aws.account.id
  
  #for existing cloud account
  #cloud_account_id   = data.spectrocloud_cloudaccount_aws.account.id
  
  cloud_config {
    ssh_key_name = var.aws_ssh_key_name
    region       = "us-east-1"
  }

  # To override or specify values for a cluster:

  # pack {
  #   name   = "spectro-byo-manifest"
  #   tag    = "1.0.x"
  #   values = <<-EOT
  #     manifests:
  #       byo-manifest:
  #         contents: |
  #           # Add manifests here
  #           apiVersion: v1
  #           kind: Namespace
  #           metadata:
  #             labels:
  #               app: wordpress
  #               app2: wordpress2
  #             name: wordpress
  #   EOT
  # }

  machine_pool {
    control_plane           = true
    control_plane_as_worker = false
    name                    = "master-pool"
    count                   = var.master-pool_node_count
    instance_type           = var.master_instance_type
    disk_size_gb            = 62
    azs                     = ["us-east-1a"]
  }

  machine_pool {
    name          = "worker-pool01"
    count         = var.worker-pool_node_count
    instance_type = var.worker_instance_type
    disk_size_gb  = 62
    azs           = ["us-east-1a"]
  }

}
