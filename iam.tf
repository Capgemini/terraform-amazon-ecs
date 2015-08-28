/* template files for registry and ecs role policies */
resource "template_file" "registry-policy" {
  filename = "policies/registry.json"

  vars {
    s3_bucket_name = "${var.s3_bucket_name}"
  }
}

resource "template_file" "ecs_role_policy" {
  filename = "policies/ecs-role-policy.json"

  vars {
    s3_bucket_name = "${var.s3_bucket_name}"
  }
}

/* registry user, access key and policies */
resource "aws_iam_user" "registry" {
  name = "${var.registry_username}"
}

resource "aws_iam_access_key" "registry" {
  user = "${aws_iam_user.registry.name}"
}

resource "aws_iam_policy" "registry" {
  name   = "registryaccess"
  policy = "${template_file.registry-policy.rendered}"
}

resource "aws_iam_policy_attachment" "registry-attach" {
  name       = "registry-attachment"
  users      = ["${aws_iam_user.registry.name}"]
  policy_arn = "${aws_iam_policy.registry.arn}"
}

/* ecs iam role and policies */
resource "aws_iam_role" "ecs_role" {
  name               = "ecs_role"
  assume_role_policy = "${file("policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "ecs_role_policy" {
  name     = "ecs_role_policy"
  policy   = "${template_file.ecs_role_policy.rendered}"
  role     = "${aws_iam_role.ecs_role.id}"
}
