resource "aws_ecr_repository" "abhishek_ecr" {
  name = "abhishek-ecr"
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.abhishek_ecr.name
  policy = file("lifecycle-policy.json")
}

output "repository_url" {
  value = aws_ecr_repository.abhishek_ecr.repository_url
}
