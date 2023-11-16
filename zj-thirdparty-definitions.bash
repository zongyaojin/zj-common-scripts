#!/bin/bash
set -exo pipefail

script_file=$(realpath "$0")
script_absolute_path=$(dirname "$script_file")
package_path=$(realpath $script_absolute_path/../..)
package_build_path=$package_path/build

package_thirdparty_path=$package_path/thirdparty
package_thirdparty_install_path=$package_thirdparty_path/install

export zj_thirdparth_build_prefix="build"

# Prioritize package_thirdparty_install_path over apt install versions by setting CMAKE_PREFIX_PATH.
export zj_thirdparty_cmake_args="-D CMAKE_BUILD_TYPE=Release \
                                 -D BUILD_SHARED_LIBS=OFF \
                                 -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
                                 -D CMAKE_PREFIX_PATH=$package_thirdparty_install_path \
                                 -D CMAKE_INSTALL_PREFIX=$package_thirdparty_install_path"

# Add installed executables to system PATH.
PATH="$PATH:$package_thirdparty_install_path/bin"
