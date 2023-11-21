#!/bin/bash
set -exo pipefail

script_file=$(realpath "$0")
script_absolute_path=$(dirname "$script_file")
package_path=$(realpath $script_absolute_path/..)

sudo apt update -y
sudo apt upgrade -y

# Install dependencies
sudo apt install -y git

# Install pip
sudo apt install -y python3-pip

# Upgrade pip and setuptools (included in Python installation)
pip install --upgrade pip setuptools

# Install cmakelang and pre-commit
pip install --user cmakelang pre-commit

# Go to the package path, set up and run pre-commit
(
    cd $package_path
    pre-commit install
    pre-commit autoupdate
    pre-commit run -a
)
