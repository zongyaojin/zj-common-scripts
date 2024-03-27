#!/bin/bash

# ####################################################################################
# This script sets up the pre-commit and run it for the package;
#   assuming there's a `.pre-commit-config.yaml` in the package root, mandoary.
#
# To unhook, run `pre-commit uninstall`
# ####################################################################################

set -exo pipefail

script_file=$(realpath "$0")
script_absolute_path=$(dirname "$script_file")
package_path=$(realpath $script_absolute_path/../..)

# Install pip
sudo apt install -y python3-pip

# Upgrade pip and setuptools (included in Python installation)
pip install --upgrade pip setuptools

# Install pre-commit
pip install --user pre-commit

# Go to the package path, set up and run pre-commit
(
  cd $package_path
  pre-commit install
  pre-commit autoupdate
  pre-commit run -a
)
