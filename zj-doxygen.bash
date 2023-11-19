#!/bin/bash
set -exo pipefail

# ####################################################################################
# This script runs doxygen to generate documentation for the package,
#   and opens firefox to display it;
#   assuming there's a `Doxyfile` in the package root path, mandatory.
# ####################################################################################

script_file=$(realpath "$0")
script_absolute_path=$(dirname "$script_file")
package_path=$(realpath $script_absolute_path/../..)
package_build_path=$package_path/build

# Path definitions
documentation_html_path=$package_path/build/doc/html

# Go to the package directory, generate doxygen and open with firefox
(
    cd $package_path
    doxygen
    firefox $documentation_html_path/index.html
)
