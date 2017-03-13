#!/usr/bin/env bash

set -x
set -e
pwd

tf_version=0.8.8
tf=`pwd`/terraform

echo "Setup terraform"
wget -N -nv https://releases.hashicorp.com/terraform/$tf_version/terraform_${tf_version}_linux_amd64.zip
unzip -o terraform_${tf_version}_linux_amd64.zip

chmod +x $tf

echo "run terraform"
cd build_pipeline/infra
$tf get
$tf plan
git status

git add terraform.tfstate terraform.tfstate.backup
git commit -m "jenkins auto-commit" || true

