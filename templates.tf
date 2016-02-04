resource "template_file" "user_data" {
  template = "${file("user-data/user-data.sh")}"
  vars {
    cluster_name    = "${aws_ecs_cluster.default.name}"
    dockerhub_auth  = "${var.dockerhub_auth}"
    dockerhub_email = "${var.dockerhub_email}"
  }
}

