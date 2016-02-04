#!/bin/bash

config_file=/etc/ecs/ecs.config

echo "ECS_CLUSTER=${cluster_name}" > $config_file
echo "ECS_ENGINE_AUTH_TYPE=dockercfg" >> $config_file
echo "ECS_ENGINE_AUTH_DATA={\"https://index.docker.io/v1/\":{\"auth\":\"${dockerhub_auth}\",\"email\":\"${dockerhub_email}\"}}" >> $config_file
