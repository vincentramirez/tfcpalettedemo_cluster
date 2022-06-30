output "cluster_id" {
  value = spectrocloud_cluster_aws.cluster.id
}

output "cluster_id" {
  value = spectrocloud_cluster_aws2.cluster.id
}

output "cluster_kubeconfig" {
  value = local.cluster_kubeconfig
}

output "cluster_kubeconfig" {
  value = local.cluster_kubeconfig2
}
