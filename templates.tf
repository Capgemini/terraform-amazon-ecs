/* template files for registry and ecs role policies */
resource "template_file" "registry-policy" {
  filename = "policies/registry.json"

  vars {
    s3_bucket_name = "${var.s3_bucket_name}"
  }
}

resource "template_file" "ecs_service_role_policy" {
  filename = "policies/ecs-service-role-policy.json"

  vars {
    s3_bucket_name = "${var.s3_bucket_name}"
  }
}
