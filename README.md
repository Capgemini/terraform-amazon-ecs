# Terraform AWS ECS (+ Docker Registry)

**Note** - This is still a work in progress, some aspects may not function quite correctly
yet... Feel free to jump in and start fixing issues.

This repo contains a [Terraform](https://www.terraform.io) plan to run up an Amazon ECS cluster with a private Docker registry.

Inspired from [http://blog.codeship.com/running-a-private-docker-registry-on-ec2/](http://blog.codeship.com/running-a-private-docker-registry-on-ec2/)

Includes -

  * Private S3 bucket for container registry data
  * Docker container running allingeek/registry:2-s3 (by default)
  * ECS cluster, launch configuration and autoscaling group

### Prerequisites

* Terraform installed, recommended (>= 0.6.3). Head on over to [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) to grab the latest version.
* An AWS account [http://aws.amazon.com/](http://aws.amazon.com/)

### Usage

1. Clone the repo
2. Set some required variables -

```
export TF_VAR_key_name=name of ssh key
export TF_VAR_key_file=the ssh key file to use
export TF_VAR_aws_access_key=The AWS access key ID
export TF_VAR_aws_secret_key=The AWS secret key
```
Run the plan -

```
terraform apply
```

Alternatively the variables can be passed on the command line e.g. -

```
terraform apply -var 'key_name=name' -var 'key_file=path_to_file' -var 'aws_access_key=access_key' -var 'aws_secret_key=secret_key'
```

For a full list of overridable variables see ```variables.tf```

### Known issues

If you are using terraform v0.6.3 and encounter this error -

```
* aws_ecs_service.s3-registry-elb: InvalidParameterException: Unable to assume role and validate the listeners configured on your load balancer.  Please verify the role being passed has the proper permissions.
  status code: 400, request id: []
```

This is probably down to this bug / issue with waits/timeouts - [https://github.com/hashicorp/terraform/issues/2869](https://github.com/hashicorp/terraform/issues/2869).

You can either compile terraform from the latest master branch, or re-run the terraform
apply again which should succeed the second time.
