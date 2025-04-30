output "repository_name" {
  value       = aws_ecr_repository.main.name
  description = "リポジトリ名"
}

output "repository_url" {
  value       = aws_ecr_repository.main.repository_url
  description = "リポジトリの URL"
}
