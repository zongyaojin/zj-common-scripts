#!/bin/bash

# ####################################################################################
# This script sets up the pre-commit and run it for the package;
#   assuming there's a `.pre-commit-config.yaml` in the package root, mandoary.
# ####################################################################################

set -exo pipefail

script_file=$(realpath "$0")
script_absolute_path=$(dirname "$script_file")
package_path=$(realpath $script_absolute_path/../..)

# Go to the source path, set up and run pre-commit
(
    cd $package_path
    pre-commit install
    pre-commit autoupdate
    pre-commit run -a
)
