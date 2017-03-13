#!/usr/bin/env bash

set -x
set -e
pwd

echo "Setup terraform"
wget -N -nv https://releases.hashicorp.com/terraform/0.8.6/terraform_0.8.6_linux_amd64.zip
unzip -o terraform_0.8.6_linux_amd64.zip

tf=`pwd`/terraform
chmod +x $tf

echo "run terraform"
cd build_pipeline/infra
$tf get
$tf plan
git status

git add terraform.tfstate terraform.tfstate.backup
git commit -m "jenkins auto-commit"

