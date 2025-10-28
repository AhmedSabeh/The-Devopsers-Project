output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "node_group_name" {
  value = module.eks.node_group_name
}

output "jenkins_master_ip" {
  value = module.ec2.jenkins_master_public_ip
}

output "jenkins_worker_ip" {
  value = module.ec2.jenkins_worker_public_ip
}

output "cloudwatch_dashboard_url" {
  value = module.cloudwatch.cloudwatch_dashboard_url
}
