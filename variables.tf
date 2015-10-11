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

variable "s3_bucket_name" {
  description = "The name of the s3 bucket to store the registry data in."
  default = "s3-ecs-docker-registry.example.com"
}

variable "registry_username" {
  description = "The username to use when connecting to the registry."
  default = "Registry"
}

variable "registry_docker_image" {
  description = "The docker image to use when provisioning the registry."
  default     = "allingeek/registry:2-s3"
}

/* ECS optimized AMIs per region */
variable "amis" {
  default = {
    ap-northeast-1 = "ami-8aa61c8a"
    ap-southeast-2 = "ami-5ddc9f67"
    eu-west-1      = "ami-2aaef35d"
    us-east-1      = "ami-b540eade"
    us-west-1      = "ami-5721df13"
    us-west-2      = "ami-cb584dfb"
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
