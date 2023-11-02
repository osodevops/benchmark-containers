#!/bin/bash
# shellcheck disable=SC2046
eval $(minikube docker-env)
docker build -t oso-iperf3:latest .