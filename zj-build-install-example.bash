#!/bin/bash

# ####################################################################################
# This script serves as an example that shows how to build and install a host package.
#
# It makes a `build/` folder and will build the package in it.
# It makes a `client-project-example` folder and will install the package in it.
#
# If there's a `thirdparty/zj-build-thirdparty.bash` script in the package,
#    that means the package needs some thridparty dependencies, this script will run it.
# If there's a `scripts/zj-package-dependencies.bash` script in the package,
#    that means the package needs some system dependencies, this script will run it.
#
# Then, it will cmake, make, install, and test the package;
#   assuming there's a `CMakeLists.txt` in the package root path, mandatory;
#   and assuming there's a `cmake/zj-cmake/modules` folder, not mandatory.
# ####################################################################################

# https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -exo pipefail

# Get this script's filename with absolute path
script_file=$(realpath "$0")
# Get this script's absolute path without the filename
script_absolute_path=$(dirname "$script_file")
# Defines the package's path
package_path=$(realpath $script_absolute_path/../..)
# Define the package's build path
package_build_path=$package_path/build

# Path to a client project example, which builds with the package as an dependency
client_project_example_path=$package_path/client-project-example
# Path to install the package from which the client project example will find it
client_project_example_install_path=$client_project_example_path/install

# Remove the build and install paths for a fresh start
rm -rf $package_build_path
rm -rf $client_project_example_install_path

# Make directories
mkdir -p $package_build_path
mkdir -p $client_project_example_install_path

package_thirdparty_build_script=$package_path/thirdparty/zj-build-thirdparty.bash
package_dependencies_install_script=$package_path/scripts/zj-package-dependencies.bash

if [ -e "$package_thirdparty_build_script" ]; then
    bash $package_thirdparty_build_script
else
    echo "no thridparty build script found"
fi

if [ -e "$package_dependencies_install_script" ]; then
    bash $package_dependencies_install_script
else
    echo "no system package dependencies install script found"
fi

# Go to the build path, build and install for client project example, and test
(
    cd $package_build_path
    cmake .. \
        -D ZJ_CODE_COVERAGE=OFF \
        -D CMAKE_INSTALL_PREFIX=$client_project_example_install_path \
        -D CMAKE_PREFIX_PATH=$package_path/thirdparty/install \
        -D CMAKE_MODULE_PATH=$package_path/cmake/zj-cmake/modules \
        -D CMAKE_BUILD_TYPE=Release \
        -D BUILD_SHARED_LIBS=OFF \
        -D BUILD_TESTING=ON
    make install
    ctest
)
