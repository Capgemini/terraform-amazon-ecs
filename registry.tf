/* Registry S3 bucket */
resource "aws_s3_bucket" "registry" {
  bucket = "${var.s3_bucket_name}"

  tags {
    Name = "Docker Registry"
  }
}

/* ELB for the registry */
resource "aws_elb" "s3-registry-elb" {
  name               = "s3-registry-elb"
  availability_zones = ["${split(",", var.availability_zones)}"]

  listener {
    instance_port     = 5000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  /* @todo - handle SSL */
  /*listener {
    instance_port = 5000
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }*/

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:5000/"
    interval            = 30
  }

  connection_draining = false

  tags {
    Name = "s3-registry-elb"
  }
}

/* container and task definitions for running the actual Docker registry */
resource "aws_ecs_service" "s3-registry-elb" {
  name            = "s3-registry-elb"
  cluster         = "${aws_ecs_cluster.default.id}"
  task_definition = "${aws_ecs_task_definition.registry.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_role.arn}"
  depends_on      = ["aws_iam_role_policy.ecs_service_role_policy"]

  load_balancer {
    elb_name       = "${aws_elb.s3-registry-elb.id}"
    container_name = "registry"
    container_port = 5000
  }
}

resource "aws_ecs_task_definition" "registry" {
  family                = "registry"
  container_definitions = "${template_file.registry_task.rendered}"
}
