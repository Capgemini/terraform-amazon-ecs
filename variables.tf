variable "aws_access_key" {
  description = "The AWS access key."
}

variable "aws_secret_key" {
  description = "The AWS secret key."
}

variable "region" {
  description = "The AWS region to create resources in."
  default = "eu-west-1"
}

variable "s3_bucket_name" {
  description = "The name of the s3 bucket to store the registry data in."
  default = "tayzlor.capgemini.com"
}

variable "registry_username" {
  description = "The username to use when connecting to the registry."
  default = "Registry"
}
