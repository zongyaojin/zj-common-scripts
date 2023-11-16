#!/bin/bash
# https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -exo pipefail

script_file=$(realpath "$0")
script_absolute_path=$(dirname "$script_file")
package_path=$(realpath $script_absolute_path/../..)
package_build_path=$package_path/build

# Path to a client project example, which builds with the package as an dependency
client_project_example_path=$package_path/client-project-example
# Path to install the package from which the client project example will find it
client_project_example_install_path=$client_project_example_path/install

# # Remove the build and install path for a fresh start
rm -rf $package_build_path
rm -rf $client_project_example_install_path

# Make directories
mkdir -p $package_build_path
mkdir -p $client_project_example_install_path

package_thirdparty_build_script=$package_path/thirdparty/zj-build-thirdparty.bash

if [ -e "$package_thirdparty_build_script" ]; then
    bash $package_thirdparty_build_script
fi

# Go to the build directory, build and install for client project example, and test
(
    cd $package_build_path
    cmake .. \
        -D ZJ_CODE_COVERAGE=OFF \
        -D CMAKE_INSTALL_PREFIX=$client_project_example_install_path \
        -D CMAKE_PREFIX_PATH=$package_path/thirdparty/install \
        -D CMAKE_MODULE_PATH=$package_path/cmake/modules \
        -D CMAKE_BUILD_TYPE=Release \
        -D BUILD_SHARED_LIBS=OFF \
        -D BUILD_TESTING=ON
    make install
    ctest
)
