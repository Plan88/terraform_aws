module "ecs_image" {
  source          = "../modules/ecr"
  repository_name = var.service_identifier
  expiration_days = 1
}
