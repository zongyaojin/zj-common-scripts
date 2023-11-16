#!/bin/bash

# https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -euxo pipefail

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
