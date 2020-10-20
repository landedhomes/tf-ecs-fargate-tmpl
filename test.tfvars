name                = "ecs-mapper"
environment         = "test"
availability_zones  = ["us-west-2a", "us-west-2b"]
private_subnets     = ["10.0.0.0/20", "10.0.32.0/20"]
public_subnets      = ["10.0.16.0/20", "10.0.48.0/20"]
tsl_certificate_arn = "arn:aws:acm:us-west-2:958018684350:certificate/169c3c6d-f9bb-4449-8860-aaf4d60fb752"
container_memory    = 512
container_image     = "mapper"
container_environment = {
  "DB_USER"     = "ro_user"
  "DB_HOST"     = "dev.cn8xtq7pqdka.us-west-2.rds.amazonaws.com"
  "DB_PORT"     = "5432"
  "DB_DATABASE" = "devdb2"
  "ENVIRONMENT" = "test"
  "APP_ENV"     = "test"
  "PATH"        = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}
