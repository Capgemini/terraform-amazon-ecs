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

variable "availability_zones" {
  description = "The availability zones"
  default = "eu-west-1a,eu-west-1b,eu-west-1c"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default = "default"
}

/* ECS optimized AMIs per region */
variable "amis" {
  default = {
    ap-northeast-1 = "ami-aa2d13c4"
    ap-southeast-2 = "ami-908faaf3"
    eu-west-1      = "ami-34a21747"
    us-east-1      = "ami-9886a0f2"
    us-west-1      = "ami-caf581aa"
    us-west-2      = "ami-1ead497e"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "The aws ssh key name."
  default = ""
}

variable "key_file" {
  description = "The ssh public key for using with the cloud provider."
  default = ""
}

variable "dockerhub_auth" {
  default = ""
}
variable "dockerhub_email" {
  default = ""
}
