/* template files for registry and ecs role policies */
resource "template_file" "registry_policy" {
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

resource "template_file" "user_data" {
  template = "${file("user-data/user-data.sh")}"
  vars {
    cluster_name    = "${aws_ecs_cluster.default.name}"
    dockerhub_auth  = "${var.dockerhub_auth}"
    dockerhub_email = "${var.dockerhub_email}"
  }
}

resource "template_file" "registry_task" {
  filename = "task-definitions/registry.json"

  vars {
    s3_bucket_name        = "${aws_s3_bucket.registry.id}"
    s3_bucket_region      = "${aws_s3_bucket.registry.region}"
    s3_bucket_access_key  = "${aws_iam_access_key.registry.id}"
    s3_bucket_secret_key  = "${aws_iam_access_key.registry.secret}"
    registry_docker_image = "${var.registry_docker_image}"
  }
}
