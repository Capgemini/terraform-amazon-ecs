output "registry.access_key" {
  value = "${aws_iam_access_key.registry.id}"
}
output "registry.secret_key" {
  value = "${aws_iam_access_key.registry.secret}"
}
output "registry.ip" {
  value = "${aws_elb.s3-registry-elb.dns_name}"
}
