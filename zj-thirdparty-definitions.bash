#!/bin/bash

# ####################################################################################
# This script defines and exports some variables for the thirdparty scripts to use.
# ####################################################################################

set -exo pipefail

# This script is supposed to be called by master script
#   `PACKAGE_ROOT/thirdparty/zj-build-thirdparty.bash`
#   and use their path to define CMake arguments,
#   so that the install path is relative to the path of the master script.
# So, it uses `$0` (the calling script's path) instead of `${BASH_SOURCE[0]}` (current script's path).
script_file=$(realpath "$0")
script_absolute_path=$(dirname "$script_file")
package_path=$(realpath $script_absolute_path/..)
package_build_path=$package_path/build

package_thirdparty_path=$package_path/thirdparty
package_thirdparty_install_path=$package_thirdparty_path/install

export zj_thirdparth_build_prefix="build"

# Prioritize `$package_thirdparty_install_path` over apt install versions by setting `CMAKE_PREFIX_PATH`.
export zj_thirdparty_cmake_args="-DCMAKE_BUILD_TYPE=Release \
                                 -DBUILD_SHARED_LIBS=OFF \
                                 -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
                                 -DCMAKE_PREFIX_PATH=$package_thirdparty_install_path \
                                 -DCMAKE_INSTALL_PREFIX=$package_thirdparty_install_path"

# Add installed executables in `bin/`, if any, to system `PATH`.
PATH="$PATH:$package_thirdparty_install_path/bin"
