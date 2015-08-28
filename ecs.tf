/* s3 bucket for registry storage */
resource "aws_s3_bucket" "registry" {
  bucket = "${var.s3_bucket_name}"

  tags {
    Name = "Docker Registry"
  }
}

/* ecs service cluster */
resource "aws_ecs_cluster" "registry" {
  name = "docker-registry"
}

/* ELB for the registry */
resource "aws_elb" "s3-registry-elb" {
  name               = "s3-registry-elb"
  /* @todo - split out to variable */
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

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

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "s3-registry-elb"
  }
}

/* container and task definitions for running the actual registry */
resource "aws_ecs_service" "s3-registry-elb" {
  name            = "s3-registry-elb"
  cluster         = "${aws_ecs_cluster.registry.id}"
  task_definition = "${aws_ecs_task_definition.registry.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_role.arn}"

  load_balancer {
    elb_name       = "${aws_elb.s3-registry-elb.id}"
    container_name = "registry"
    container_port = 5000
  }
}

resource "template_file" "registry-task" {
  filename = "task-definitions/registry.json"

  vars {
    s3_bucket_name       = "${aws_s3_bucket.registry.id}"
    s3_bucket_region     = "${aws_s3_bucket.registry.region}"
    s3_bucket_access_key = "${aws_iam_access_key.registry.id}"
    s3_bucket_secret_key = "${aws_iam_access_key.registry.secret}"
  }
}

resource "aws_ecs_task_definition" "registry" {
  family                = "registry"
  container_definitions = "${template_file.registry-task.rendered}"
}
