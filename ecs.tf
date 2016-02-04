/* SSH key pair */
resource "aws_key_pair" "ecs" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.key_file)}"
}

/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs" {
  name                 = "ecs"
  image_id             = "${lookup(var.amis, var.region)}"
  /* @todo - split out to a variable */
  instance_type        = "${var.instance_type}"
  key_name             = "${aws_key_pair.ecs.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  security_groups      = ["${aws_security_group.ecs.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
  user_data            = "${template_file.user_data.rendered}"
}

/**
 * Autoscaling group.
 */
resource "aws_autoscaling_group" "ecs" {
  name                 = "ecs-asg"
  availability_zones   = ["${split(",", var.availability_zones)}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  /* @todo - variablize */
  min_size             = 1
  max_size             = 10
  desired_capacity     = 2
}

/* ecs service cluster */
resource "aws_ecs_cluster" "default" {
  name = "${var.ecs_cluster_name}"
}
