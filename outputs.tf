output "registry.dns_name" {
  value = "${aws_elb.s3-registry-elb.dns_name}"
}
