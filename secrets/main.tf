# This file creates secrets in the AWS Secret Manager
# Note that this does not contain any actual secret values
# make sure to not commit any secret values to git!
# you could put them in secrets.tfvars which is in .gitignore


resource "aws_secretsmanager_secret" "application_secrets" {
  count = length(var.application-secrets)
  recovery_window_in_days = "0"
  name  = "${var.name}-application-secrets-${var.environment}-${element(keys(var.application-secrets), count.index)}-1"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_secretsmanager_secret_version" "application_secrets_values" {
  count         = length(var.application-secrets)
  secret_id     = element(aws_secretsmanager_secret.application_secrets.*.id, count.index)
  secret_string = element(values(var.application-secrets), count.index)
}

locals {
  secrets = zipmap(keys(var.application-secrets), aws_secretsmanager_secret_version.application_secrets_values.*.arn)

  secretMap = [for secretKey in keys(var.application-secrets) : {
    name      = secretKey
    valueFrom = lookup(local.secrets, secretKey)
    }

  ]
}

output "application_secrets_arn" {
  value = aws_secretsmanager_secret_version.application_secrets_values.*.arn
}

output "secrets_map" {
  value = local.secretMap
}

