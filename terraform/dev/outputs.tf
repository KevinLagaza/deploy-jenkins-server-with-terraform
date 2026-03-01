output "jenkins_url" {
  description = "URL to access Jenkins"
  value       = module.eip.public_dns
  sensitive = true
}